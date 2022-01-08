defmodule YicWeb.Html.Iam.DenieController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Denie

  def index(conn, _params) do
    denies = Iam.list_denies()
    render(conn, "index.html", denies: denies)
  end

  def new(conn, _params) do
    changeset = Iam.change_denie(%Denie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"denie" => denie_params}) do
    case Iam.create_denie(denie_params) do
      {:ok, denie} ->
        conn
        |> put_flash(:info, "Denie created successfully.")
        |> redirect(to: Routes.html_iam_denie_path(conn, :show, denie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    denie = Iam.get_denie!(id)
    render(conn, "show.html", denie: denie)
  end

  def edit(conn, %{"id" => id}) do
    denie = Iam.get_denie!(id)
    changeset = Iam.change_denie(denie)
    render(conn, "edit.html", denie: denie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "denie" => denie_params}) do
    denie = Iam.get_denie!(id)

    case Iam.update_denie(denie, denie_params) do
      {:ok, denie} ->
        conn
        |> put_flash(:info, "Denie updated successfully.")
        |> redirect(to: Routes.html_iam_denie_path(conn, :show, denie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", denie: denie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    denie = Iam.get_denie!(id)
    {:ok, _denie} = Iam.delete_denie(denie)

    conn
    |> put_flash(:info, "Denie deleted successfully.")
    |> redirect(to: Routes.html_iam_denie_path(conn, :index))
  end
end
