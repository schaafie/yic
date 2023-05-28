defmodule YicWeb.Html.Forms.DatadefController do
  use YicWeb, :controller
  require Logger
  alias Yic.Forms
  alias Yic.Forms.Datadef

  def index(conn, _params) do
    datadefs = Forms.list_datadefs()
    render(conn, "index.html", datadefs: datadefs)
  end

  def new(conn, _params) do
    changeset = Forms.change_datadef(%Datadef{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"datadef" => datadef_params}) do
    case Forms.create_datadef(datadef_params) do
      {:ok, datadef} ->
        conn
        |> put_flash(:info, "Datadef created successfully.")
        |> redirect(to: Routes.html_forms_datadef_path(conn, :show, datadef))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    datadef = Forms.get_datadef!(id)
    render(conn, "show.html", datadef: datadef)
  end

  def edit(conn, %{"id" => id}) do
    datadef = Forms.get_datadef!(id)
    changeset = Forms.change_datadef(datadef)
    render(conn, "edit.html", datadef: datadef, changeset: changeset)
  end

  def update(conn, %{"id" => id, "datadef" => datadef_params}) do
    datadef = Forms.get_datadef!(id)

    case Forms.update_datadef(datadef, datadef_params) do
      {:ok, datadef} ->
        conn
        |> put_flash(:info, "Datadef updated successfully.")
        |> redirect(to: Routes.html_forms_datadef_path(conn, :show, datadef))

      {:error, %Ecto.Changeset{} = changeset} ->
        Logger.error changeset
        render(conn, "edit.html", datadef: datadef, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    datadef = Forms.get_datadef!(id)
    {:ok, _datadef} = Forms.delete_datadef(datadef)

    conn
    |> put_flash(:info, "Datadef deleted successfully.")
    |> redirect(to: Routes.html_forms_datadef_path(conn, :index))
  end
end
