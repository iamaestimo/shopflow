defmodule Shopflow.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shopflow.Catalog` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some description",
        id: "some id",
        is_active: true,
        name: "some name"
      })
      |> Shopflow.Catalog.create_category()

    category
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2025-08-24 08:41:00Z],
        description: "some description",
        id: "some id",
        is_active: true,
        name: "some name",
        price: "120.5",
        sku: "some sku"
      })
      |> Shopflow.Catalog.create_product()

    product
  end
end
