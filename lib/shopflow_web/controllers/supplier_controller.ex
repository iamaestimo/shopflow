defmodule ShopflowWeb.SupplierController do
  use ShopflowWeb, :controller

  alias Shopflow.Suppliers

  def show(conn, %{"id" => id}) do
    supplier = Suppliers.get_supplier!(id)
    render(conn, :show, supplier: supplier)
  end
end
