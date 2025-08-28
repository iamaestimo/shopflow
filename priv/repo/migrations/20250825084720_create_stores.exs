defmodule Shopflow.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :location, :string
      add :is_active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
