defmodule Shopflow.Repo.Migrations.CreatePriceHistory do
  use Ecto.Migration

  def change do
    create table(:price_history, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :old_price, :decimal
      add :new_price, :decimal
      add :change_reason, :string
      add :effective_date, :utc_datetime
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)
      add :supplier_id, references(:suppliers, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:price_history, [:product_id])
    create index(:price_history, [:supplier_id])
  end
end
