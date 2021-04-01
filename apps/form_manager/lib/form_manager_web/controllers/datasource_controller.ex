defmodule FormManagerWeb.DatasourceController do
  use FormManagerWeb, :controller

  alias FormManager.Forms
  alias FormManager.Forms.Datasource

  action_fallback FormManagerWeb.FallbackController

  def index(conn, _params) do
    datasources = Forms.list_datasources()
    render(conn, "index.json", datasources: datasources)
  end

  def create(conn, %{"datasource" => datasource_params}) do
    with {:ok, %Datasource{} = datasource} <- Forms.create_datasource(datasource_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", datasource_path(conn, :show, datasource))
      |> render("show.json", datasource: datasource)
    end
  end

  def show(conn, %{"id" => id}) do
    datasource = Forms.get_datasource!(id)
    render(conn, "show.json", datasource: datasource)
  end

  def update(conn, %{"id" => id, "datasource" => datasource_params}) do
    datasource = Forms.get_datasource!(id)

    with {:ok, %Datasource{} = datasource} <- Forms.update_datasource(datasource, datasource_params) do
      render(conn, "show.json", datasource: datasource)
    end
  end

  def delete(conn, %{"id" => id}) do
    datasource = Forms.get_datasource!(id)
    with {:ok, %Datasource{}} <- Forms.delete_datasource(datasource) do
      send_resp(conn, :no_content, "")
    end
  end
end
