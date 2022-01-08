defmodule YicWeb.Html.Iam.UsersController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Users

  def index(conn, _params) do
    users = Iam.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Iam.change_users(%Users{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"users" => users_params}) do
    case Iam.create_users(users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users created successfully.")
        |> redirect(to: Routes.html_iam_users_path(conn, :show, users))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Iam.get_users!(id)
    render(conn, "show.html", users: users)
  end

  def edit(conn, %{"id" => id}) do
    users = Iam.get_users!(id)
    changeset = Iam.change_users(users)
    render(conn, "edit.html", users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Iam.get_users!(id)

    case Iam.update_users(users, users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users updated successfully.")
        |> redirect(to: Routes.html_iam_users_path(conn, :show, users))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", users: users, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Iam.get_users!(id)
    {:ok, _users} = Iam.delete_users(users)

    conn
    |> put_flash(:info, "Users deleted successfully.")
    |> redirect(to: Routes.html_iam_users_path(conn, :index))
  end
end
