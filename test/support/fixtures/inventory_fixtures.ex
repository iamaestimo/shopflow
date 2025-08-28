defmodule Shopflow.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shopflow.Inventory` context.
  """

  @doc """
  Generate a store.
  """
  def store_fixture(attrs \\ %{}) do
    {:ok, store} =
      attrs
      |> Enum.into(%{
        id: "some id",
        is_active: true,
        location: "some location",
        name: "some name"
      })
      |> Shopflow.Inventory.create_store()

    store
  end

  @doc """
  Generate a stock.
  """
  def stock_fixture(attrs \\ %{}) do
    {:ok, stock} =
      attrs
      |> Enum.into(%{
        id: "some id",
        last_restocked_at: ~U[2025-08-24 08:50:00Z],
        quantity: 42,
        reorder_level: 42,
        reserved_quantity: 42
      })
      |> Shopflow.Inventory.create_stock()

    stock
  end
end
