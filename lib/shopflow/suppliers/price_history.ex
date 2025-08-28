defmodule Shopflow.Suppliers.PriceHistory do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "price_history" do
    field :old_price, :decimal
    field :new_price, :decimal
    field :change_reason, :string
    field :effective_date, :utc_datetime
    belongs_to :product, Shopflow.Catalog.Product
    belongs_to :supplier, Shopflow.Suppliers.Supplier

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(price_history, attrs) do
    price_history
    |> cast(attrs, [:old_price, :new_price, :change_reason, :effective_date, :product_id, :supplier_id])
    |> validate_required([:new_price, :effective_date, :product_id, :supplier_id])
    |> validate_number(:new_price, greater_than: 0)
  end
end
