defmodule Shopflow.OrdersTest do
  use Shopflow.DataCase

  alias Shopflow.Orders

  describe "orders" do
    alias Shopflow.Orders.Order

    import Shopflow.OrdersFixtures

    @invalid_attrs %{id: nil, status: nil, order_number: nil, customer_email: nil, total_amount: nil, order_date: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{id: "some id", status: "some status", order_number: "some order_number", customer_email: "some customer_email", total_amount: "120.5", order_date: ~U[2025-08-24 08:50:00Z]}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.id == "some id"
      assert order.status == "some status"
      assert order.order_number == "some order_number"
      assert order.customer_email == "some customer_email"
      assert order.total_amount == Decimal.new("120.5")
      assert order.order_date == ~U[2025-08-24 08:50:00Z]
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{id: "some updated id", status: "some updated status", order_number: "some updated order_number", customer_email: "some updated customer_email", total_amount: "456.7", order_date: ~U[2025-08-25 08:50:00Z]}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.id == "some updated id"
      assert order.status == "some updated status"
      assert order.order_number == "some updated order_number"
      assert order.customer_email == "some updated customer_email"
      assert order.total_amount == Decimal.new("456.7")
      assert order.order_date == ~U[2025-08-25 08:50:00Z]
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end

  describe "order_items" do
    alias Shopflow.Orders.OrderItem

    import Shopflow.OrdersFixtures

    @invalid_attrs %{id: nil, quantity: nil, unit_price: nil, total_price: nil}

    test "list_order_items/0 returns all order_items" do
      order_item = order_item_fixture()
      assert Orders.list_order_items() == [order_item]
    end

    test "get_order_item!/1 returns the order_item with given id" do
      order_item = order_item_fixture()
      assert Orders.get_order_item!(order_item.id) == order_item
    end

    test "create_order_item/1 with valid data creates a order_item" do
      valid_attrs = %{id: "some id", quantity: 42, unit_price: "120.5", total_price: "120.5"}

      assert {:ok, %OrderItem{} = order_item} = Orders.create_order_item(valid_attrs)
      assert order_item.id == "some id"
      assert order_item.quantity == 42
      assert order_item.unit_price == Decimal.new("120.5")
      assert order_item.total_price == Decimal.new("120.5")
    end

    test "create_order_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order_item(@invalid_attrs)
    end

    test "update_order_item/2 with valid data updates the order_item" do
      order_item = order_item_fixture()
      update_attrs = %{id: "some updated id", quantity: 43, unit_price: "456.7", total_price: "456.7"}

      assert {:ok, %OrderItem{} = order_item} = Orders.update_order_item(order_item, update_attrs)
      assert order_item.id == "some updated id"
      assert order_item.quantity == 43
      assert order_item.unit_price == Decimal.new("456.7")
      assert order_item.total_price == Decimal.new("456.7")
    end

    test "update_order_item/2 with invalid data returns error changeset" do
      order_item = order_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order_item(order_item, @invalid_attrs)
      assert order_item == Orders.get_order_item!(order_item.id)
    end

    test "delete_order_item/1 deletes the order_item" do
      order_item = order_item_fixture()
      assert {:ok, %OrderItem{}} = Orders.delete_order_item(order_item)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order_item!(order_item.id) end
    end

    test "change_order_item/1 returns a order_item changeset" do
      order_item = order_item_fixture()
      assert %Ecto.Changeset{} = Orders.change_order_item(order_item)
    end
  end
end
