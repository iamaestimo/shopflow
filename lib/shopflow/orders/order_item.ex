defmodule Shopflow.Orders.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "order_items" do
    field :quantity, :integer
    field :unit_price, :decimal
    field :total_price, :decimal
    belongs_to :order, Shopflow.Orders.Order
    belongs_to :product, Shopflow.Catalog.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:quantity, :unit_price, :total_price, :order_id, :product_id])
    |> validate_required([:quantity, :unit_price, :total_price, :order_id, :product_id])
    |> validate_number(:quantity, greater_than: 0)
    |> validate_number(:unit_price, greater_than: 0)
    |> calculate_total_price()
  end

  defp calculate_total_price(changeset) do
    case {get_field(changeset, :quantity), get_field(changeset, :unit_price)} do
      {quantity, unit_price} when is_integer(quantity) and not is_nil(unit_price) ->
        total = Decimal.mult(unit_price, quantity)
        put_change(changeset, :total_price, total)
      _ ->
        changeset
    end
  end
end
