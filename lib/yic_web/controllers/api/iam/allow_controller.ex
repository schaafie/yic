defmodule YicWeb.Api.Iam.AllowController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Allow

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    allows = Iam.list_allows()
    render(conn, "index.json", allows: allows)
  end

  def create(conn, %{"allow" => allow_params}) do
    with {:ok, %Allow{} = allow} <- Iam.create_allow(allow_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_iam_allow_path(conn, :show, allow))
      |> render("show.json", allow: allow)
    end
  end

  def show(conn, %{"id" => id}) do
    allow = Iam.get_allow!(id)
    render(conn, "show.json", allow: allow)
  end

  def update(conn, %{"id" => id, "allow" => allow_params}) do
    allow = Iam.get_allow!(id)

    with {:ok, %Allow{} = allow} <- Iam.update_allow(allow, allow_params) do
      render(conn, "show.json", allow: allow)
    end
  end

  def delete(conn, %{"id" => id}) do
    allow = Iam.get_allow!(id)

    with {:ok, %Allow{}} <- Iam.delete_allow(allow) do
      send_resp(conn, :no_content, "")
    end
  end
end
