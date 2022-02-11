defmodule YicWeb.Api.Apis.ApiView do
  use YicWeb, :view
  alias YicWeb.Api.Apis.ApiView

  def render("index.json", %{apis: apis}) do
    %{data: render_many(apis, ApiView, "api.json")}
  end

  def render("show.json", %{api: api}) do
    %{data: render_one(api, ApiView, "api.json")}
  end

  def render("api.json", %{api: api}) do
    %{
      id: api.id,
      name: api.name,
      description: api.description,
      version: api.version,
      request: api.request,
      definition: api.definition
    }
  end

  def render("respons.json", %{data: data}), do: data
end