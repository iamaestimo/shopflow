defmodule Shopflow.InventoryTest do
  use Shopflow.DataCase

  alias Shopflow.Inventory

  describe "stores" do
    alias Shopflow.Inventory.Store

    import Shopflow.InventoryFixtures

    @invalid_attrs %{id: nil, name: nil, location: nil, is_active: nil}

    test "list_stores/0 returns all stores" do
      store = store_fixture()
      assert Inventory.list_stores() == [store]
    end

    test "get_store!/1 returns the store with given id" do
      store = store_fixture()
      assert Inventory.get_store!(store.id) == store
    end

    test "create_store/1 with valid data creates a store" do
      valid_attrs = %{id: "some id", name: "some name", location: "some location", is_active: true}

      assert {:ok, %Store{} = store} = Inventory.create_store(valid_attrs)
      assert store.id == "some id"
      assert store.name == "some name"
      assert store.location == "some location"
      assert store.is_active == true
    end

    test "create_store/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_store(@invalid_attrs)
    end

    test "update_store/2 with valid data updates the store" do
      store = store_fixture()
      update_attrs = %{id: "some updated id", name: "some updated name", location: "some updated location", is_active: false}

      assert {:ok, %Store{} = store} = Inventory.update_store(store, update_attrs)
      assert store.id == "some updated id"
      assert store.name == "some updated name"
      assert store.location == "some updated location"
      assert store.is_active == false
    end

    test "update_store/2 with invalid data returns error changeset" do
      store = store_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_store(store, @invalid_attrs)
      assert store == Inventory.get_store!(store.id)
    end

    test "delete_store/1 deletes the store" do
      store = store_fixture()
      assert {:ok, %Store{}} = Inventory.delete_store(store)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_store!(store.id) end
    end

    test "change_store/1 returns a store changeset" do
      store = store_fixture()
      assert %Ecto.Changeset{} = Inventory.change_store(store)
    end
  end

  describe "inventory" do
    alias Shopflow.Inventory.Stock

    import Shopflow.InventoryFixtures

    @invalid_attrs %{id: nil, quantity: nil, reserved_quantity: nil, reorder_level: nil, last_restocked_at: nil}

    test "list_inventory/0 returns all inventory" do
      stock = stock_fixture()
      assert Inventory.list_inventory() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Inventory.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      valid_attrs = %{id: "some id", quantity: 42, reserved_quantity: 42, reorder_level: 42, last_restocked_at: ~U[2025-08-24 08:50:00Z]}

      assert {:ok, %Stock{} = stock} = Inventory.create_stock(valid_attrs)
      assert stock.id == "some id"
      assert stock.quantity == 42
      assert stock.reserved_quantity == 42
      assert stock.reorder_level == 42
      assert stock.last_restocked_at == ~U[2025-08-24 08:50:00Z]
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{id: "some updated id", quantity: 43, reserved_quantity: 43, reorder_level: 43, last_restocked_at: ~U[2025-08-25 08:50:00Z]}

      assert {:ok, %Stock{} = stock} = Inventory.update_stock(stock, update_attrs)
      assert stock.id == "some updated id"
      assert stock.quantity == 43
      assert stock.reserved_quantity == 43
      assert stock.reorder_level == 43
      assert stock.last_restocked_at == ~U[2025-08-25 08:50:00Z]
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_stock(stock, @invalid_attrs)
      assert stock == Inventory.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Inventory.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Inventory.change_stock(stock)
    end
  end
end
