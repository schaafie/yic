defmodule FormManagerWeb.DatasourceView do
  use FormManagerWeb, :view
  alias FormManagerWeb.DatasourceView

  def render("index.json", %{datasources: datasources}) do
    %{data: render_many(datasources, DatasourceView, "datasource.json")}
  end

  def render("show.json", %{datasource: datasource}) do
    %{data: render_one(datasource, DatasourceView, "datasource.json")}
  end

  def render("datasource.json", %{datasource: datasource}) do
    %{id: datasource.id,
      name: datasource.name,
      comment: datasource.comment,
      version: datasource.version,
      definition: datasource.definition,
      actions: datasource.actions}
  end
end
