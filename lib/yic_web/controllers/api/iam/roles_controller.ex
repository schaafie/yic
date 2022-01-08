defmodule YicWeb.Api.Iam.RolesController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Roles

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    roles = Iam.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"roles" => roles_params}) do
    with {:ok, %Roles{} = roles} <- Iam.create_roles(roles_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_iam_roles_path(conn, :show, roles))
      |> render("show.json", roles: roles)
    end
  end

  def show(conn, %{"id" => id}) do
    roles = Iam.get_roles!(id)
    render(conn, "show.json", roles: roles)
  end

  def update(conn, %{"id" => id, "roles" => roles_params}) do
    roles = Iam.get_roles!(id)

    with {:ok, %Roles{} = roles} <- Iam.update_roles(roles, roles_params) do
      render(conn, "show.json", roles: roles)
    end
  end

  def delete(conn, %{"id" => id}) do
    roles = Iam.get_roles!(id)

    with {:ok, %Roles{}} <- Iam.delete_roles(roles) do
      send_resp(conn, :no_content, "")
    end
  end
end
