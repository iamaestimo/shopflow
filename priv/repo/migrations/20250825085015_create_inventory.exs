defmodule Shopflow.Repo.Migrations.CreateInventory do
  use Ecto.Migration

  def change do
    create table(:inventory, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :reserved_quantity, :integer
      add :reorder_level, :integer
      add :last_restocked_at, :utc_datetime
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)
      add :store_id, references(:stores, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:inventory, [:product_id])
    create index(:inventory, [:store_id])
  end
end
