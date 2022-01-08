defmodule YicWeb.Html.Iam.GroupsController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Groups

  def index(conn, _params) do
    groups = Iam.list_groups()
    render(conn, "index.html", groups: groups)
  end

  def new(conn, _params) do
    changeset = Iam.change_groups(%Groups{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"groups" => groups_params}) do
    case Iam.create_groups(groups_params) do
      {:ok, groups} ->
        conn
        |> put_flash(:info, "Groups created successfully.")
        |> redirect(to: Routes.html_iam_groups_path(conn, :show, groups))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    groups = Iam.get_groups!(id)
    render(conn, "show.html", groups: groups)
  end

  def edit(conn, %{"id" => id}) do
    groups = Iam.get_groups!(id)
    changeset = Iam.change_groups(groups)
    render(conn, "edit.html", groups: groups, changeset: changeset)
  end

  def update(conn, %{"id" => id, "groups" => groups_params}) do
    groups = Iam.get_groups!(id)

    case Iam.update_groups(groups, groups_params) do
      {:ok, groups} ->
        conn
        |> put_flash(:info, "Groups updated successfully.")
        |> redirect(to: Routes.html_iam_groups_path(conn, :show, groups))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", groups: groups, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    groups = Iam.get_groups!(id)
    {:ok, _groups} = Iam.delete_groups(groups)

    conn
    |> put_flash(:info, "Groups deleted successfully.")
    |> redirect(to: Routes.html_iam_groups_path(conn, :index))
  end
end
