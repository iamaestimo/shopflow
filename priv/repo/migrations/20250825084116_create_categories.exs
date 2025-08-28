defmodule Shopflow.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text
      add :is_active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
