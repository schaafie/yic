defmodule YicWeb.Html.Iam.RolesController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Roles

  def index(conn, _params) do
    roles = Iam.list_roles()
    render(conn, "index.html", roles: roles)
  end

  def new(conn, _params) do
    changeset = Iam.change_roles(%Roles{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"roles" => roles_params}) do
    case Iam.create_roles(roles_params) do
      {:ok, roles} ->
        conn
        |> put_flash(:info, "Roles created successfully.")
        |> redirect(to: Routes.html_iam_roles_path(conn, :show, roles))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    roles = Iam.get_roles!(id)
    render(conn, "show.html", roles: roles)
  end

  def edit(conn, %{"id" => id}) do
    roles = Iam.get_roles!(id)
    changeset = Iam.change_roles(roles)
    render(conn, "edit.html", roles: roles, changeset: changeset)
  end

  def update(conn, %{"id" => id, "roles" => roles_params}) do
    roles = Iam.get_roles!(id)

    case Iam.update_roles(roles, roles_params) do
      {:ok, roles} ->
        conn
        |> put_flash(:info, "Roles updated successfully.")
        |> redirect(to: Routes.html_iam_roles_path(conn, :show, roles))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", roles: roles, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    roles = Iam.get_roles!(id)
    {:ok, _roles} = Iam.delete_roles(roles)

    conn
    |> put_flash(:info, "Roles deleted successfully.")
    |> redirect(to: Routes.html_iam_roles_path(conn, :index))
  end
end
