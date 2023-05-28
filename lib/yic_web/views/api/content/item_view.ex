defmodule YicWeb.Api.Content.ItemView do
  use YicWeb, :view
  alias YicWeb.Api.Content.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{
      id: item.id,
      name: item.name,
      description: item.description,
      version: item.version,
      content: item.content
    }
  end
end
