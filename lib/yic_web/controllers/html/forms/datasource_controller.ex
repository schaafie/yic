defmodule YicWeb.Html.Forms.DatasourceController do
  use YicWeb, :controller

  alias Yic.Forms
  alias Yic.Forms.Datasource

  def index(conn, _params) do
    datasources = Forms.list_datasources()
    render(conn, "index.html", datasources: datasources)
  end

  def new(conn, _params) do
    changeset = Forms.change_datasource(%Datasource{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"datasource" => datasource_params}) do
    case Forms.create_datasource(datasource_params) do
      {:ok, datasource} ->
        conn
        |> put_flash(:info, "Datasource created successfully.")
        |> redirect(to: Routes.html_forms_datasource_path(conn, :show, datasource))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    datasource = Forms.get_datasource!(id)
    render(conn, "show.html", datasource: datasource)
  end

  def edit(conn, %{"id" => id}) do
    datasource = Forms.get_datasource!(id)
    changeset = Forms.change_datasource(datasource)
    render(conn, "edit.html", datasource: datasource, changeset: changeset)
  end

  def update(conn, %{"id" => id, "datasource" => datasource_params}) do
    datasource = Forms.get_datasource!(id)

    case Forms.update_datasource(datasource, datasource_params) do
      {:ok, datasource} ->
        conn
        |> put_flash(:info, "Datasource updated successfully.")
        |> redirect(to: Routes.html_forms_datasource_path(conn, :show, datasource))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", datasource: datasource, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    datasource = Forms.get_datasource!(id)
    {:ok, _datasource} = Forms.delete_datasource(datasource)

    conn
    |> put_flash(:info, "Datasource deleted successfully.")
    |> redirect(to: Routes.html_forms_datasource_path(conn, :index))
  end
end
