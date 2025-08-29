defmodule ShopflowWeb.ProductController do
  use ShopflowWeb, :controller

  alias Shopflow.Catalog
  alias Shopflow.Catalog.Product
  alias Shopflow.Suppliers

  def index(conn, _params) do
    products = Catalog.list_products()
    # products = Catalog.list_products_with_n_plus_one()
    render(conn, :index, products: products)
  end

  def show(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)
    render(conn, :show, product: product)
  end

  def new(conn, _params) do
    changeset = Catalog.change_product(%Product{})
    categories = Catalog.list_categories()
    suppliers = Suppliers.list_suppliers()
    render(conn, :new, changeset: changeset, categories: categories, suppliers: suppliers)
  end

  def create(conn, %{"product" => product_params}) do
    case Catalog.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        categories = Catalog.list_categories()
        suppliers = Suppliers.list_suppliers()
        render(conn, :new, changeset: changeset, categories: categories, suppliers: suppliers)
    end
  end

  def edit(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)
    changeset = Catalog.change_product(product)
    categories = Catalog.list_categories()
    suppliers = Suppliers.list_suppliers()
    render(conn, :edit, product: product, changeset: changeset, categories: categories, suppliers: suppliers)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Catalog.get_product!(id)

    case Catalog.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        categories = Catalog.list_categories()
        suppliers = Suppliers.list_suppliers()
        render(conn, :edit, product: product, changeset: changeset, categories: categories, suppliers: suppliers)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)
    {:ok, _product} = Catalog.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: ~p"/products")
  end
end
