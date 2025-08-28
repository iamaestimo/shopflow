defmodule Shopflow.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "products" do
    field :name, :string
    field :description, :string
    field :sku, :string
    field :price, :decimal
    field :is_active, :boolean, default: false
    field :deleted_at, :utc_datetime
    belongs_to :category, Shopflow.Catalog.Category
    belongs_to :supplier, Shopflow.Suppliers.Supplier

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :sku, :price, :is_active, :deleted_at, :category_id, :supplier_id])
    |> validate_required([:id, :name, :sku, :price, :category_id, :supplier_id])
    |> unique_constraint(:sku)
  end

  def soft_delete_changeset(product) do
    change(product, deleted_at: DateTime.utc_now())
  end
end
