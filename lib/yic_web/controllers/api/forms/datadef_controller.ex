defmodule YicWeb.Api.Forms.DatadefController do
  use YicWeb, :controller

  alias Yic.Forms
  alias Yic.Forms.Datadef

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    datadefs = Forms.list_datadefs()
    render(conn, "index.json", datadefs: datadefs)
  end

  def create(conn, %{"datadef" => datadef_params}) do
    with {:ok, %Datadef{} = datadef} <- Forms.create_datadef(datadef_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_forms_datadef_path(conn, :show, datadef))
      |> render("show.json", datadef: datadef)
    end
  end

  def show(conn, %{"id" => id}) do
    datadef = Forms.get_datadef!(id)
    render(conn, "show.json", datadef: datadef)
  end

  def show(conn, %{"name" => name}) do
    datadef = Forms.get_datadef_by_name!(name)
    render(conn, "show.json", datadef: datadef)
  end

  def update(conn, datadef_params) do
    datadef = Forms.get_datadef!(datadef_params["id"])
    case Forms.update_datadef(datadef, datadef_params) do
      {:ok, datadef} ->
        render(conn, "show.json", datadef: datadef)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)      
    end
  end

  def delete(conn, %{"id" => id}) do
    datadef = Forms.get_datadef!(id)

    with {:ok, %Datadef{}} <- Forms.delete_datadef(datadef) do
      send_resp(conn, :no_content, "")
    end
  end
end
