defmodule Shopflow.SuppliersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shopflow.Suppliers` context.
  """

  @doc """
  Generate a supplier.
  """
  def supplier_fixture(attrs \\ %{}) do
    {:ok, supplier} =
      attrs
      |> Enum.into(%{
        contact_email: "some contact_email",
        contact_phone: "some contact_phone",
        id: "some id",
        is_active: true,
        name: "some name"
      })
      |> Shopflow.Suppliers.create_supplier()

    supplier
  end

  @doc """
  Generate a price_history.
  """
  def price_history_fixture(attrs \\ %{}) do
    {:ok, price_history} =
      attrs
      |> Enum.into(%{
        change_reason: "some change_reason",
        effective_date: ~U[2025-08-24 08:43:00Z],
        id: "some id",
        new_price: "120.5",
        old_price: "120.5"
      })
      |> Shopflow.Suppliers.create_price_history()

    price_history
  end
end
