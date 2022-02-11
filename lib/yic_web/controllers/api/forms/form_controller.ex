defmodule YicWeb.Api.Forms.FormController do
  use YicWeb, :controller

  alias Yic.Forms
  alias Yic.Forms.Form

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    forms = Forms.list_forms()
    render(conn, "index.json", forms: forms)
  end

  def create(conn, %{"form" => form_params}) do
    with {:ok, %Form{} = form} <- Forms.create_form(form_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_forms_form_path(conn, :show, form))
      |> render("show.json", form: form)
    end
  end

  def show(conn, %{"id" => id}) do
    form = Forms.get_form!(id)
    render(conn, "show.json", form: form)
  end

  def update(conn, %{"id" => id, "form" => form_params}) do
    form = Forms.get_form!(id)

    with {:ok, %Form{} = form} <- Forms.update_form(form, form_params) do
      render(conn, "show.json", form: form)
    end
  end

  def delete(conn, %{"id" => id}) do
    form = Forms.get_form!(id)

    with {:ok, %Form{}} <- Forms.delete_form(form) do
      send_resp(conn, :no_content, "")
    end
  end

  def datadef( conn, _params) do
    formdef = Forms.get_datadef()
    respons = Poison.encode!(formdef)
    send_resp(conn, 200, respons)
  end
end
