defmodule Shopflow.CatalogTest do
  use Shopflow.DataCase

  alias Shopflow.Catalog

  describe "categories" do
    alias Shopflow.Catalog.Category

    import Shopflow.CatalogFixtures

    @invalid_attrs %{id: nil, name: nil, description: nil, is_active: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Catalog.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Catalog.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{id: "some id", name: "some name", description: "some description", is_active: true}

      assert {:ok, %Category{} = category} = Catalog.create_category(valid_attrs)
      assert category.id == "some id"
      assert category.name == "some name"
      assert category.description == "some description"
      assert category.is_active == true
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{id: "some updated id", name: "some updated name", description: "some updated description", is_active: false}

      assert {:ok, %Category{} = category} = Catalog.update_category(category, update_attrs)
      assert category.id == "some updated id"
      assert category.name == "some updated name"
      assert category.description == "some updated description"
      assert category.is_active == false
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_category(category, @invalid_attrs)
      assert category == Catalog.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Catalog.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Catalog.change_category(category)
    end
  end

  describe "products" do
    alias Shopflow.Catalog.Product

    import Shopflow.CatalogFixtures

    @invalid_attrs %{id: nil, name: nil, description: nil, sku: nil, price: nil, is_active: nil, deleted_at: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{id: "some id", name: "some name", description: "some description", sku: "some sku", price: "120.5", is_active: true, deleted_at: ~U[2025-08-24 08:41:00Z]}

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.id == "some id"
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.sku == "some sku"
      assert product.price == Decimal.new("120.5")
      assert product.is_active == true
      assert product.deleted_at == ~U[2025-08-24 08:41:00Z]
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{id: "some updated id", name: "some updated name", description: "some updated description", sku: "some updated sku", price: "456.7", is_active: false, deleted_at: ~U[2025-08-25 08:41:00Z]}

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.id == "some updated id"
      assert product.name == "some updated name"
      assert product.description == "some updated description"
      assert product.sku == "some updated sku"
      assert product.price == Decimal.new("456.7")
      assert product.is_active == false
      assert product.deleted_at == ~U[2025-08-25 08:41:00Z]
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end
end
