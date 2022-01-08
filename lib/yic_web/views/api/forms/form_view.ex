defmodule YicWeb.Api.Forms.FormView do
  use YicWeb, :view
  alias YicWeb.Api.Forms.FormView

  def render("index.json", %{forms: forms}) do
    %{data: render_many(forms, FormView, "form.json")}
  end

  def render("show.json", %{form: form}) do
    %{data: render_one(form, FormView, "form.json")}
  end

  def render("form.json", %{form: form}) do
    %{
      id: form.id,
      name: form.name,
      comment: form.comment,
      version: form.version,
      definition: form.definition
    }
  end
end
