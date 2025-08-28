defmodule Shopflow.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :order_number, :string
      add :customer_email, :string
      add :status, :string
      add :total_amount, :decimal
      add :order_date, :utc_datetime
      add :store_id, references(:stores, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:orders, [:store_id])
  end
end
