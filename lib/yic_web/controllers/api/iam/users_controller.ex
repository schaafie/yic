defmodule YicWeb.Api.Iam.UsersController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Users

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    users = Iam.list_users()
    render(conn, "index.json", users: users)
  end

  # def create(conn, %{"users" => users_params}) do
  def create(conn, users_params) do
      with {:ok, %Users{} = users} <- Iam.create_users(users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_iam_users_path(conn, :show, users))
      |> render("show.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Iam.get_users!(id)
    render(conn, "show.json", users: users)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Iam.get_users!(id)

    with {:ok, %Users{} = users} <- Iam.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Iam.get_users!(id)

    with {:ok, %Users{}} <- Iam.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end
end
