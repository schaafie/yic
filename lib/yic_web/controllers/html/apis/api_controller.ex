defmodule YicWeb.Html.Apis.ApiController do
  use YicWeb, :controller

  alias Yic.Apis
  alias Yic.Apis.Api

  def index(conn, _params) do
    apis = Apis.list_apis()
    render(conn, "index.html", apis: apis)
  end

  def new(conn, _params) do
    changeset = Apis.change_api(%Api{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"api" => api_params}) do
    case Apis.create_api(api_params) do
      {:ok, api} ->
        conn
        |> put_flash(:info, "Api created successfully.")
        |> redirect(to: Routes.html_apis_api_path(conn, :show, api))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    api = Apis.get_api!(id)
    render(conn, "show.html", api: api)
  end

  def edit(conn, %{"id" => id}) do
    api = Apis.get_api!(id)
    changeset = Apis.change_api(api)
    render(conn, "edit.html", api: api, changeset: changeset)
  end

  def update(conn, %{"id" => id, "api" => api_params}) do
    api = Apis.get_api!(id)

    case Apis.update_api(api, api_params) do
      {:ok, api} ->
        conn
        |> put_flash(:info, "Api updated successfully.")
        |> redirect(to: Routes.html_apis_api_path(conn, :show, api))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", api: api, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    api = Apis.get_api!(id)
    {:ok, _api} = Apis.delete_api(api)

    conn
    |> put_flash(:info, "Api deleted successfully.")
    |> redirect(to: Routes.html_apis_api_path(conn, :index))
  end
end
