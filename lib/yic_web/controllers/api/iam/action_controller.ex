defmodule YicWeb.Api.Iam.ActionController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Action

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    actions = Iam.list_actions()
    render(conn, "index.json", actions: actions)
  end

  def create(conn, %{"action" => action_params}) do
    with {:ok, %Action{} = action} <- Iam.create_action(action_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_iam_action_path(conn, :show, action))
      |> render("show.json", action: action)
    end
  end

  def show(conn, %{"id" => id}) do
    action = Iam.get_action!(id)
    render(conn, "show.json", action: action)
  end

  def update(conn, %{"id" => id, "action" => action_params}) do
    action = Iam.get_action!(id)

    with {:ok, %Action{} = action} <- Iam.update_action(action, action_params) do
      render(conn, "show.json", action: action)
    end
  end

  def delete(conn, %{"id" => id}) do
    action = Iam.get_action!(id)

    with {:ok, %Action{}} <- Iam.delete_action(action) do
      send_resp(conn, :no_content, "")
    end
  end
end
