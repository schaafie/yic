defmodule YicWeb.Api.Forms.DatadefView do
  use YicWeb, :view
  alias YicWeb.Api.Forms.DatadefView

  def render("index.json", %{datadefs: datadefs}) do
    %{data: render_many(datadefs, DatadefView, "datadef.json")}
  end

  def render("show.json", %{datadef: datadef}) do
    %{data: render_one(datadef, DatadefView, "datadef.json")}
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
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

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &error2map/1)
  end

  def error2map error do
    {msg, opts} = error
    #TODO Convert options to format that Jason can handle
    
    %{ message: msg, options: Enum.into( opts, %{} ) }
  end
    
end
