defmodule Shopflow.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text
      add :sku, :string
      add :price, :decimal
      add :is_active, :boolean, default: false, null: false
      add :deleted_at, :utc_datetime
      add :category_id, references(:categories, on_delete: :nothing, type: :binary_id)
      add :supplier_id, references(:suppliers, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:products, [:category_id])
    create index(:products, [:supplier_id])
  end
end
