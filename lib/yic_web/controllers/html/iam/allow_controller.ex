defmodule YicWeb.Html.Iam.AllowController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Allow

  def index(conn, _params) do
    allows = Iam.list_allows()
    render(conn, "index.html", allows: allows)
  end

  def new(conn, _params) do
    changeset = Iam.change_allow(%Allow{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"allow" => allow_params}) do
    case Iam.create_allow(allow_params) do
      {:ok, allow} ->
        conn
        |> put_flash(:info, "Allow created successfully.")
        |> redirect(to: Routes.html_iam_allow_path(conn, :show, allow))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    allow = Iam.get_allow!(id)
    render(conn, "show.html", allow: allow)
  end

  def edit(conn, %{"id" => id}) do
    allow = Iam.get_allow!(id)
    changeset = Iam.change_allow(allow)
    render(conn, "edit.html", allow: allow, changeset: changeset)
  end

  def update(conn, %{"id" => id, "allow" => allow_params}) do
    allow = Iam.get_allow!(id)

    case Iam.update_allow(allow, allow_params) do
      {:ok, allow} ->
        conn
        |> put_flash(:info, "Allow updated successfully.")
        |> redirect(to: Routes.html_iam_allow_path(conn, :show, allow))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", allow: allow, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    allow = Iam.get_allow!(id)
    {:ok, _allow} = Iam.delete_allow(allow)

    conn
    |> put_flash(:info, "Allow deleted successfully.")
    |> redirect(to: Routes.html_iam_allow_path(conn, :index))
  end
end
