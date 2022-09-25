defmodule YicWeb.Api.Forms.FormView do
  use YicWeb, :view
  alias YicWeb.Api.Forms.FormView

  def render("index.json", %{forms: forms}) do
    %{data: render_many(forms, FormView, "form.json")}
  end

  def render("show.json", %{form: form}) do
    %{data: render_one(form, FormView, "form.json")}
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end

  def render("form.json", %{form: form}) do
    %{
      id: form.id,
      name: form.name,
      comment: form.comment,
      version: form.version,
      definition: form.definition,
      author: form.author
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
