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

  @doc """
  Renders the CSV import modal.
  """
  attr :id, :string, required: true

  def import_modal(assigns) do
    ~H"""
    <div id={@id} class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
      <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
        <div class="mt-3 text-center">
          <h3 class="text-lg font-medium text-gray-900 mb-4">Import Products from CSV</h3>

          <.simple_form :let={f} for={%{}} action={~p"/products/import"} multipart={true}>
            <div class="mb-4">
              <.input
                field={f[:csv_file]}
                type="file"
                label="Select CSV File"
                accept=".csv"
                required={true}
              />
            </div>

            <div class="text-sm text-gray-600 mb-4 text-left">
              <p class="font-medium mb-2">CSV Format Requirements:</p>
              <ul class="list-disc list-inside space-y-1">
                <li>Headers: name, sku, price, category_id, supplier_id</li>
                <li>Optional: description, is_active</li>
                <li>Use existing category and supplier IDs</li>
                <li>Price should be numeric (e.g., 29.99)</li>
                <li>is_active: true/false (defaults to true)</li>
              </ul>
            </div>

            <div class="flex items-center justify-between gap-4">
              <button
                type="button"
                onclick="document.getElementById('{@id}').classList.add('hidden')"
                class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-300"
              >
                Cancel
              </button>
              <.button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-300">
                Import CSV
              </.button>
            </div>
          </.simple_form>
        </div>
      </div>
    </div>
    """
  end
end
