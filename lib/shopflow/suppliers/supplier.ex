defmodule Shopflow.Suppliers.Supplier do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "suppliers" do
    field :name, :string
    field :contact_email, :string
    field :contact_phone, :string
    field :is_active, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(supplier, attrs) do
    supplier
    |> cast(attrs, [:name, :contact_email, :contact_phone, :is_active])
    |> validate_required([:name])
    |> validate_format(:contact_email, ~r/@/)
  end
end
