defmodule Shopflow.Inventory.Store do
  use Ecto.Schema
  import Ecto.Changeset

@primary_key {:id, :binary_id, autogenerate: true}
@foreign_key_type :binary_id

schema "stores" do
  field :name, :string
  field :location, :string
  field :is_active, :boolean, default: false

  timestamps(type: :utc_datetime)
end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name, :location, :is_active])
    |> validate_required([:name, :location])
  end
end
