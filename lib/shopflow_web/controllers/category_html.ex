defmodule ShopflowWeb.CategoryHTML do
  use ShopflowWeb, :html

  embed_templates "category_html/*"

  @doc """
  Renders a category form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def category_form(assigns) do
    ~H"""
    <.simple_form :let={f} for={@changeset} action={@action}>
      <.error :if={@changeset.action}>
        Oops, something went wrong! Please check the errors below.
      </.error>
      <.input field={f[:name]} type="text" label="Name" />
      <.input field={f[:description]} type="textarea" label="Description" />
      <.input field={f[:is_active]} type="checkbox" label="Is active" />
      <:actions>
        <.button>Save Category</.button>
      </:actions>
    </.simple_form>
    """
  end
end
