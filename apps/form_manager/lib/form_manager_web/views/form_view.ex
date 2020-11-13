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

  def render("definition.json", _args ) do
    %{ elements: [
        %{ name: "id", type: "integer", validations: [], required: "true" },
        %{ name: "name", type: "string", validations: [], required: "true" },
        %{ name: "version", type: "string", validations: [], required: "true" },
        %{ name: "author", type: "string", validations: [], required: "true" },
        %{ name: "definition", type: "formdefinition", validations: [], required: "true" } ],
      globalValidations: [],
      restapi: ""
    }
    
  end
end
