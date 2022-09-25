defmodule YicWeb.Api.Forms.DatadefView do
  use YicWeb, :view
  alias YicWeb.Api.Forms.DatadefView

  def render("index.json", %{datadefs: datadefs}) do
    %{data: render_many(datadefs, DatadefView, "datadef.json")}
  end

  def render("show.json", %{datadef: datadef}) do
    %{data: render_one(datadef, DatadefView, "datadef.json")}
  end

  def render("datadef.json", %{datadef: datadef}) do
    %{
      id: datadef.id,
      name: datadef.name,
      comment: datadef.comment,
      version: datadef.version,
      definition: datadef.definition
    }
  end
end
