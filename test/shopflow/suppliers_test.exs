defmodule Shopflow.SuppliersTest do
  use Shopflow.DataCase

  alias Shopflow.Suppliers

  describe "suppliers" do
    alias Shopflow.Suppliers.Supplier

    import Shopflow.SuppliersFixtures

    @invalid_attrs %{id: nil, name: nil, contact_email: nil, contact_phone: nil, is_active: nil}

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Suppliers.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Suppliers.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      valid_attrs = %{id: "some id", name: "some name", contact_email: "some contact_email", contact_phone: "some contact_phone", is_active: true}

      assert {:ok, %Supplier{} = supplier} = Suppliers.create_supplier(valid_attrs)
      assert supplier.id == "some id"
      assert supplier.name == "some name"
      assert supplier.contact_email == "some contact_email"
      assert supplier.contact_phone == "some contact_phone"
      assert supplier.is_active == true
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Suppliers.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      update_attrs = %{id: "some updated id", name: "some updated name", contact_email: "some updated contact_email", contact_phone: "some updated contact_phone", is_active: false}

      assert {:ok, %Supplier{} = supplier} = Suppliers.update_supplier(supplier, update_attrs)
      assert supplier.id == "some updated id"
      assert supplier.name == "some updated name"
      assert supplier.contact_email == "some updated contact_email"
      assert supplier.contact_phone == "some updated contact_phone"
      assert supplier.is_active == false
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Suppliers.update_supplier(supplier, @invalid_attrs)
      assert supplier == Suppliers.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Suppliers.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Suppliers.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Suppliers.change_supplier(supplier)
    end
  end

  describe "price_history" do
    alias Shopflow.Suppliers.PriceHistory

    import Shopflow.SuppliersFixtures

    @invalid_attrs %{id: nil, old_price: nil, new_price: nil, change_reason: nil, effective_date: nil}

    test "list_price_history/0 returns all price_history" do
      price_history = price_history_fixture()
      assert Suppliers.list_price_history() == [price_history]
    end

    test "get_price_history!/1 returns the price_history with given id" do
      price_history = price_history_fixture()
      assert Suppliers.get_price_history!(price_history.id) == price_history
    end

    test "create_price_history/1 with valid data creates a price_history" do
      valid_attrs = %{id: "some id", old_price: "120.5", new_price: "120.5", change_reason: "some change_reason", effective_date: ~U[2025-08-24 08:43:00Z]}

      assert {:ok, %PriceHistory{} = price_history} = Suppliers.create_price_history(valid_attrs)
      assert price_history.id == "some id"
      assert price_history.old_price == Decimal.new("120.5")
      assert price_history.new_price == Decimal.new("120.5")
      assert price_history.change_reason == "some change_reason"
      assert price_history.effective_date == ~U[2025-08-24 08:43:00Z]
    end

    test "create_price_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Suppliers.create_price_history(@invalid_attrs)
    end

    test "update_price_history/2 with valid data updates the price_history" do
      price_history = price_history_fixture()
      update_attrs = %{id: "some updated id", old_price: "456.7", new_price: "456.7", change_reason: "some updated change_reason", effective_date: ~U[2025-08-25 08:43:00Z]}

      assert {:ok, %PriceHistory{} = price_history} = Suppliers.update_price_history(price_history, update_attrs)
      assert price_history.id == "some updated id"
      assert price_history.old_price == Decimal.new("456.7")
      assert price_history.new_price == Decimal.new("456.7")
      assert price_history.change_reason == "some updated change_reason"
      assert price_history.effective_date == ~U[2025-08-25 08:43:00Z]
    end

    test "update_price_history/2 with invalid data returns error changeset" do
      price_history = price_history_fixture()
      assert {:error, %Ecto.Changeset{}} = Suppliers.update_price_history(price_history, @invalid_attrs)
      assert price_history == Suppliers.get_price_history!(price_history.id)
    end

    test "delete_price_history/1 deletes the price_history" do
      price_history = price_history_fixture()
      assert {:ok, %PriceHistory{}} = Suppliers.delete_price_history(price_history)
      assert_raise Ecto.NoResultsError, fn -> Suppliers.get_price_history!(price_history.id) end
    end

    test "change_price_history/1 returns a price_history changeset" do
      price_history = price_history_fixture()
      assert %Ecto.Changeset{} = Suppliers.change_price_history(price_history)
    end
  end
end
