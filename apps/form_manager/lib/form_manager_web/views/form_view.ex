defmodule FormManagerWeb.FormView do
  use FormManagerWeb, :view
  alias FormManagerWeb.FormView

  def render("index.json", %{forms: forms}) do
    %{data: render_many(forms, FormView, "form.json")}
  end

  def render("show.json", %{form: form}) do
    %{data: render_one(form, FormView, "form.json")}
  end

  def render("form.json", %{form: form}) do
    %{id: form.id,
      name: form.name,
      version: form.version,
      author: form.author,
      definition: form.definition}
  end

end
