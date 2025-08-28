defmodule Shopflow.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "orders" do
    field :status, Ecto.Enum, values: [:pending, :processing, :shipped, :delivered, :cancelled]
    field :order_number, :string
    field :customer_email, :string
    field :total_amount, :decimal
    field :order_date, :utc_datetime
    belongs_to :store, Shopflow.Inventory.Store

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:order_number, :customer_email, :status, :total_amount, :order_date, :store_id])
    |> validate_required([:order_number, :customer_email, :status, :total_amount, :order_date, :store_id])
  end
end
