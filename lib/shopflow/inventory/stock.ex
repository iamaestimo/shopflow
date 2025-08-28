defmodule Shopflow.Inventory.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "inventory" do
    field :quantity, :integer
    field :reserved_quantity, :integer
    field :reorder_level, :integer
    field :last_restocked_at, :utc_datetime
    belongs_to :product, Shopflow.Catalog.Product
    belongs_to :store, Shopflow.Inventory.Store

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:quantity, :reserved_quantity, :reorder_level, :last_restocked_at, :product_id, :store_id])
    |> validate_required([:quantity, :reserved_quantity, :reorder_level, :last_restocked_at, :product_id, :store_id])
    |> validate_number(:quantity, greater_than_or_equal_to: 0)
    |> validate_number(:reserved_quantity, greater_than_or_equal_to: 0)
  end

  def available_quantity(%__MODULE__{quantity: qty, reserved_quantity: reserved}) do
    qty - reserved
  end
end
