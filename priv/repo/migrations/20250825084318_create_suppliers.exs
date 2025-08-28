defmodule Shopflow.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :contact_email, :string
      add :contact_phone, :string
      add :is_active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
