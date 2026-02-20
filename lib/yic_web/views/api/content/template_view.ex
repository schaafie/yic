defmodule YicWeb.Api.Content.TemplateView do
  use YicWeb, :view
  alias YicWeb.Api.Content.TemplateView

  def render("index.json", %{templates: templates}) do
    %{data: render_many(templates, TemplateView, "template.json")}
  end

  def render("show.json", %{template: template}) do
    %{data: render_one(template, TemplateView, "template.json")}
  end

  def render("template.json", %{template: template}) do
    %{
      id: template.id,
      name: template.name,
      comment: template.comment,
      owner: template.owner,
      version: template.version,
      definition: template.definition
    }
  end
end
