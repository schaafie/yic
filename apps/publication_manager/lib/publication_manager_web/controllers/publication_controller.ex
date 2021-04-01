defmodule PublicationManagerWeb.PublicationController do
  use PublicationManagerWeb, :controller

  alias PublicationManager.Publications
  alias PublicationManager.Publications.Publication

  action_fallback PublicationManagerWeb.FallbackController

  def index(conn, _params) do
    publications = Publications.list_publications()
    render(conn, "index.json", publications: publications)
  end

  def create(conn, %{"publication" => publication_params}) do
    with {:ok, %Publication{} = publication} <- Publications.create_publication(publication_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", publication_path(conn, :show, publication))
      |> render("show.json", publication: publication)
    end
  end

  def show(conn, %{"id" => id}) do
    publication = Publications.get_publication!(id)
    render(conn, "show.json", publication: publication)
  end

  def getbyname(conn, %{"name" => name, "id" => id}) do
    publication = Publications.get_publication_by_name!(name, id)
    # IO.inspect publication
    # Poison.decode!(publication)
    render(conn, "show.json", publication: publication )
  end

  def getbyname(conn, %{"name" => name}) do
    publication = Publications.get_publication_by_name!(name)
    # IO.inspect publication
    # IO.inspect publication
    # Poison.decode!(publication)
    render(conn, "show.json", publication: publication )
  end

  def update(conn, %{"id" => id, "publication" => publication_params}) do
    publication = Publications.get_publication!(id)

    with {:ok, %Publication{} = publication} <- Publications.update_publication(publication, publication_params) do
      render(conn, "show.json", publication: publication)
    end
  end

  def delete(conn, %{"id" => id}) do
    publication = Publications.get_publication!(id)
    with {:ok, %Publication{}} <- Publications.delete_publication(publication) do
      send_resp(conn, :no_content, "")
    end
  end
end
