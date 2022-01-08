defmodule YicWeb.Api.Iam.GroupsController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Groups

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    groups = Iam.list_groups()
    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"groups" => groups_params}) do
    with {:ok, %Groups{} = groups} <- Iam.create_groups(groups_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_iam_groups_path(conn, :show, groups))
      |> render("show.json", groups: groups)
    end
  end

  def show(conn, %{"id" => id}) do
    groups = Iam.get_groups!(id)
    render(conn, "show.json", groups: groups)
  end

  def update(conn, %{"id" => id, "groups" => groups_params}) do
    groups = Iam.get_groups!(id)

    with {:ok, %Groups{} = groups} <- Iam.update_groups(groups, groups_params) do
      render(conn, "show.json", groups: groups)
    end
  end

  def delete(conn, %{"id" => id}) do
    groups = Iam.get_groups!(id)

    with {:ok, %Groups{}} <- Iam.delete_groups(groups) do
      send_resp(conn, :no_content, "")
    end
  end
end
