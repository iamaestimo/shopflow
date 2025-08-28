defmodule Shopflow.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shopflow.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        customer_email: "some customer_email",
        id: "some id",
        order_date: ~U[2025-08-24 08:50:00Z],
        order_number: "some order_number",
        status: "some status",
        total_amount: "120.5"
      })
      |> Shopflow.Orders.create_order()

    order
  end

  @doc """
  Generate a order_item.
  """
  def order_item_fixture(attrs \\ %{}) do
    {:ok, order_item} =
      attrs
      |> Enum.into(%{
        id: "some id",
        quantity: 42,
        total_price: "120.5",
        unit_price: "120.5"
      })
      |> Shopflow.Orders.create_order_item()

    order_item
  end
end
