defmodule ShopflowWeb.ProductHTML do
  use ShopflowWeb, :html

  embed_templates "product_html/*"

  @doc """
  Renders a product form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :categories, :list, required: true
  attr :suppliers, :list, required: true

  def product_form(assigns) do
    ~H"""
    <.simple_form :let={f} for={@changeset} action={@action}>
      <.error :if={@changeset.action}>
        Oops, something went wrong! Please check the errors below.
      </.error>
      <.input field={f[:name]} type="text" label="Name" />
      <.input field={f[:description]} type="textarea" label="Description" />
      <.input field={f[:sku]} type="text" label="SKU" />
      <.input field={f[:price]} type="number" label="Price" step="0.01" />
      <.input
        field={f[:category_id]}
        type="select"
        label="Category"
        options={category_options(@categories)}
        prompt="Select a category"
      />
      <.input
        field={f[:supplier_id]}
        type="select"
        label="Supplier"
        options={supplier_options(@suppliers)}
        prompt="Select a supplier"
      />
      <.input field={f[:is_active]} type="checkbox" label="Is active" />
      <:actions>
        <.button>Save Product</.button>
      </:actions>
    </.simple_form>
    """
  end

  defp category_options(categories) do
    Enum.map(categories, fn category ->
      {category.name, category.id}
    end)
  end

  defp supplier_options(suppliers) do
    Enum.map(suppliers, fn supplier ->
      {supplier.name, supplier.id}
    end)
  end
end
