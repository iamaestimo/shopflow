defmodule Shopflow.Suppliers do
  @moduledoc """
  The Suppliers context.
  """

  import Ecto.Query, warn: false
  alias Shopflow.Repo

  alias Shopflow.Suppliers.Supplier

  @doc """
  Returns the list of suppliers.

  ## Examples

      iex> list_suppliers()
      [%Supplier{}, ...]

  """
  def list_suppliers do
    Repo.all(Supplier)
  end

  @doc """
  Gets a single supplier.

  Raises `Ecto.NoResultsError` if the Supplier does not exist.

  ## Examples

      iex> get_supplier!(123)
      %Supplier{}

      iex> get_supplier!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supplier!(id), do: Repo.get!(Supplier, id)

  @doc """
  Creates a supplier.

  ## Examples

      iex> create_supplier(%{field: value})
      {:ok, %Supplier{}}

      iex> create_supplier(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supplier(attrs \\ %{}) do
    %Supplier{}
    |> Supplier.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supplier.

  ## Examples

      iex> update_supplier(supplier, %{field: new_value})
      {:ok, %Supplier{}}

      iex> update_supplier(supplier, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supplier(%Supplier{} = supplier, attrs) do
    supplier
    |> Supplier.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a supplier.

  ## Examples

      iex> delete_supplier(supplier)
      {:ok, %Supplier{}}

      iex> delete_supplier(supplier)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supplier(%Supplier{} = supplier) do
    Repo.delete(supplier)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supplier changes.

  ## Examples

      iex> change_supplier(supplier)
      %Ecto.Changeset{data: %Supplier{}}

  """
  def change_supplier(%Supplier{} = supplier, attrs \\ %{}) do
    Supplier.changeset(supplier, attrs)
  end

  alias Shopflow.Suppliers.PriceHistory

  @doc """
  Returns the list of price_history.

  ## Examples

      iex> list_price_history()
      [%PriceHistory{}, ...]

  """
  def list_price_history do
    Repo.all(PriceHistory)
  end

  @doc """
  Gets a single price_history.

  Raises `Ecto.NoResultsError` if the Price history does not exist.

  ## Examples

      iex> get_price_history!(123)
      %PriceHistory{}

      iex> get_price_history!(456)
      ** (Ecto.NoResultsError)

  """
  def get_price_history!(id), do: Repo.get!(PriceHistory, id)

  @doc """
  Creates a price_history.

  ## Examples

      iex> create_price_history(%{field: value})
      {:ok, %PriceHistory{}}

      iex> create_price_history(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_price_history(attrs \\ %{}) do
    %PriceHistory{}
    |> PriceHistory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a price_history.

  ## Examples

      iex> update_price_history(price_history, %{field: new_value})
      {:ok, %PriceHistory{}}

      iex> update_price_history(price_history, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_price_history(%PriceHistory{} = price_history, attrs) do
    price_history
    |> PriceHistory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a price_history.

  ## Examples

      iex> delete_price_history(price_history)
      {:ok, %PriceHistory{}}

      iex> delete_price_history(price_history)
      {:error, %Ecto.Changeset{}}

  """
  def delete_price_history(%PriceHistory{} = price_history) do
    Repo.delete(price_history)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking price_history changes.

  ## Examples

      iex> change_price_history(price_history)
      %Ecto.Changeset{data: %PriceHistory{}}

  """
  def change_price_history(%PriceHistory{} = price_history, attrs \\ %{}) do
    PriceHistory.changeset(price_history, attrs)
  end
end
