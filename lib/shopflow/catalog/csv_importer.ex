defmodule Shopflow.Catalog.CsvImporter do
  @moduledoc """
  Handles CSV import functionality for products.
  """

  import Ecto.Query
  alias Shopflow.Repo
  alias Shopflow.Catalog.Product
  alias Shopflow.Catalog
  alias Shopflow.Suppliers
  alias NimbleCSV.RFC4180, as: CSV

  @required_headers ["name", "sku", "price", "category_id", "supplier_id"]
  @optional_headers ["description", "is_active"]
  @all_headers @required_headers ++ @optional_headers

  @doc """
  Imports products from a CSV file.

  Returns {:ok, count} on success or {:error, reason} on failure.
  """
  def import_csv(file_path) do
    result = with {:ok, csv_data} <- read_and_parse_csv(file_path),
         {:ok, headers} <- validate_headers(csv_data),
         {:ok, products_data} <- validate_and_transform_data(csv_data, headers) do
      insert_products(products_data)
    end

    # Track failures with Appsignal
    case result do
      {:error, _reason} ->
        Appsignal.increment_counter("csv_import.failure")
        Appsignal.add_distribution_value("csv_import.error_rate", 1)
      {:ok, _} ->
        Appsignal.increment_counter("csv_import.success")
        Appsignal.add_distribution_value("csv_import.error_rate", 0)
      _ ->
        :ok
    end

    result
  end

  defp read_and_parse_csv(file_path) do
    try do
      csv_data =
        file_path
        |> File.stream!()
        |> CSV.parse_stream(skip_headers: false)
        |> Enum.to_list()

      case csv_data do
        [] -> {:error, "CSV file is empty"}
        [_headers | _rows] -> {:ok, csv_data}
      end
    rescue
      e -> {:error, "Failed to parse CSV: #{Exception.message(e)}"}
    end
  end

  defp validate_headers([headers | _rows]) do
    headers = Enum.map(headers, &String.downcase/1)

    missing_required = @required_headers -- headers

    case missing_required do
      [] -> {:ok, headers}
      missing -> {:error, "Missing required headers: #{Enum.join(missing, ", ")}"}
    end
  end

  defp validate_and_transform_data([headers | rows], _validated_headers) do
    headers = Enum.map(headers, &String.downcase/1)

    results =
      rows
      |> Enum.with_index(2) # Start from row 2 (accounting for header)
      |> Enum.map(fn {row, line_number} ->
        validate_and_transform_row(headers, row, line_number)
      end)

    errors = Enum.filter(results, &match?({:error, _}, &1))

    case errors do
      [] ->
        products_data = Enum.map(results, fn {:ok, data} -> data end)
        {:ok, products_data}
      errors ->
        error_messages = Enum.map(errors, fn {:error, msg} -> msg end)
        {:error, "Validation errors:\n" <> Enum.join(error_messages, "\n")}
    end
  end

  defp validate_and_transform_row(headers, row, line_number) do
    try do
      # Create a map from headers and row data
      row_data =
        headers
        |> Enum.zip(row)
        |> Enum.into(%{})
        |> transform_row_data()

      # Validate using Product changeset
      changeset = %Product{} |> Product.changeset(row_data)

      if changeset.valid? do
        {:ok, row_data}
      else
        errors =
          changeset.errors
          |> Enum.map(fn {field, {message, _}} -> "#{field}: #{message}" end)
          |> Enum.join(", ")

        {:error, "Line #{line_number}: #{errors}"}
      end
    rescue
      e -> {:error, "Line #{line_number}: #{Exception.message(e)}"}
    end
  end

  defp transform_row_data(row_data) do
    row_data
    |> transform_price()
    |> transform_boolean("is_active", true) # Default to true if not specified
    |> validate_foreign_keys()
    |> Map.take(@all_headers) # Only keep valid fields
  end

  defp transform_price(%{"price" => price_str} = row_data) when is_binary(price_str) do
    case Decimal.parse(price_str) do
      {decimal, ""} -> Map.put(row_data, "price", decimal)
      _ -> Map.put(row_data, "price", price_str) # Let changeset validation handle the error
    end
  end
  defp transform_price(row_data), do: row_data

  defp transform_boolean(row_data, field, default) do
    case Map.get(row_data, field) do
      val when val in ["true", "TRUE", "1", "yes", "YES"] ->
        Map.put(row_data, field, true)
      val when val in ["false", "FALSE", "0", "no", "NO"] ->
        Map.put(row_data, field, false)
      nil ->
        Map.put(row_data, field, default)
      "" ->
        Map.put(row_data, field, default)
      other ->
        Map.put(row_data, field, other) # Let changeset validation handle invalid values
    end
  end

  defp validate_foreign_keys(row_data) do
    # Check if category_id exists
    row_data = validate_category_id(row_data)
    # Check if supplier_id exists
    validate_supplier_id(row_data)
  end

  defp validate_category_id(%{"category_id" => category_id} = row_data) when is_binary(category_id) do
    case Catalog.get_category!(category_id) do
      %Shopflow.Catalog.Category{} -> row_data
      _ -> Map.put(row_data, "category_id", nil) # Will trigger validation error
    end
  rescue
    Ecto.NoResultsError -> Map.put(row_data, "category_id", nil)
  end
  defp validate_category_id(row_data), do: row_data

  defp validate_supplier_id(%{"supplier_id" => supplier_id} = row_data) when is_binary(supplier_id) do
    case Suppliers.get_supplier!(supplier_id) do
      %Shopflow.Suppliers.Supplier{} -> row_data
      _ -> Map.put(row_data, "supplier_id", nil) # Will trigger validation error
    end
  rescue
    Ecto.NoResultsError -> Map.put(row_data, "supplier_id", nil)
  end
  defp validate_supplier_id(row_data), do: row_data

  defp insert_products(products_data) do
    batch_size = length(products_data)

    Repo.transaction(fn ->
      # Check for SKU duplicates within the CSV
      skus = Enum.map(products_data, & &1["sku"])
      duplicate_skus = skus -- Enum.uniq(skus)

      unless Enum.empty?(duplicate_skus) do
        Repo.rollback("Duplicate SKUs found in CSV: #{Enum.join(duplicate_skus, ", ")}")
      end

      # Check for existing SKUs in database
      existing_skus =
        from(p in Product,
          where: p.sku in ^skus,
          select: p.sku
        )
        |> Repo.all()

      unless Enum.empty?(existing_skus) do
        Repo.rollback("SKUs already exist in database: #{Enum.join(existing_skus, ", ")}")
      end

      # Prepare data for bulk insert
      now = DateTime.utc_now() |> DateTime.truncate(:second)

      products_for_insert =
        Enum.map(products_data, fn product_data ->
          product_data
          |> Map.put("id", Ecto.UUID.generate())
          |> Map.put("inserted_at", now)
          |> Map.put("updated_at", now)
          |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
          |> Enum.into(%{})
        end)

      # Bulk insert with Appsignal instrumentation
      {count, _} = Appsignal.instrument(
        "csv_import.bulk_insert",
        "db.bulk_insert",
        fn ->
          Repo.insert_all(Product, products_for_insert)
        end
      )

      # Set additional metrics after successful insert
      Appsignal.set_gauge("csv_import.batch_size", batch_size)
      Appsignal.set_gauge("csv_import.records_inserted", count)
      Appsignal.increment_counter("csv_import.success")

      count
    end)
  end
end
