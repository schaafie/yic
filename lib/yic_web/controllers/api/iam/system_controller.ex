defmodule YicWeb.Api.Iam.SystemController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.System

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    systems = Iam.list_systems()
    render(conn, "index.json", systems: systems)
  end

  def create(conn, %{"system" => system_params}) do
    with {:ok, %System{} = system} <- Iam.create_system(system_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_iam_system_path(conn, :show, system))
      |> render("show.json", system: system)
    end
  end

  def show(conn, %{"id" => id}) do
    system = Iam.get_system!(id)
    render(conn, "show.json", system: system)
  end

  def update(conn, %{"id" => id, "system" => system_params}) do
    system = Iam.get_system!(id)

    with {:ok, %System{} = system} <- Iam.update_system(system, system_params) do
      render(conn, "show.json", system: system)
    end
  end

  def delete(conn, %{"id" => id}) do
    system = Iam.get_system!(id)

    with {:ok, %System{}} <- Iam.delete_system(system) do
      send_resp(conn, :no_content, "")
    end
  end
end
