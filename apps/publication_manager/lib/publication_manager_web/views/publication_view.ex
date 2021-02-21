defmodule PublicationManagerWeb.PublicationView do
  use PublicationManagerWeb, :view
  alias PublicationManagerWeb.PublicationView

  def render("index.json", %{publications: publications}) do
    %{data: render_many(publications, PublicationView, "publication.json")}
  end

  def render("show.json", %{publication: publication}) do
    %{data: render_one(publication, PublicationView, "publication.json")}
  end

  def render("publication.json", %{publication: publication}) do
    %{id: publication.id,
      target: publication.target,
      path: publication.path,
      version: publication.version,
      definition: publication.definition,
      start: publication.start,
      end: publication.end}
  end
end
