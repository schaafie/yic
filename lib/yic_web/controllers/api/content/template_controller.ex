defmodule YicWeb.Api.Content.TemplateController do
  use YicWeb, :controller

  alias Yic.Content
  alias Yic.Content.Template

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    templates = Content.list_templates()
    render(conn, "index.json", templates: templates)
  end

  def create(conn, %{"template" => template_params}) do
    with {:ok, %Template{} = template} <- Content.create_template(template_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_content_template_path(conn, :show, template))
      |> render("show.json", template: template)
    end
  end

  def show(conn, %{"id" => id}) do
    template = Content.get_template!(id)
    render(conn, "show.json", template: template)
  end

  def update(conn, %{"id" => id, "template" => template_params}) do
    template = Content.get_template!(id)

    with {:ok, %Template{} = template} <- Content.update_template(template, template_params) do
      render(conn, "show.json", template: template)
    end
  end

  def delete(conn, %{"id" => id}) do
    template = Content.get_template!(id)

    with {:ok, %Template{}} <- Content.delete_template(template) do
      send_resp(conn, :no_content, "")
    end
  end
end
