defmodule YicWeb.Html.Content.TemplateController do
  use YicWeb, :controller
  require Logger
  alias Yic.Content
  alias Yic.Content.Template

  def index(conn, _params) do
    templates = Content.list_templates()
    render(conn, "index.html", templates: templates)
  end

  def new(conn, _params) do
    changeset = Content.change_template(%Template{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"template" => template_params}) do
    case Content.create_template(template_params) do
      {:ok, template} ->
        conn
        |> put_flash(:info, "Template created successfully.")
        |> redirect(to: Routes.html_content_template_path(conn, :show, template))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    template = Content.get_template!(id)
    render(conn, "show.html", template: template)
  end

  def edit(conn, %{"id" => id}) do
    template = Content.get_template!(id)
    changeset = Content.change_template(template)
    render(conn, "edit.html", template: template, changeset: changeset)
  end

  def update(conn, %{"id" => id, "template" => template_params}) do
    template = Content.get_template!(id)

    case Content.update_template(template, template_params) do
      {:ok, template} ->
        conn
        |> put_flash(:info, "Template updated successfully.")
        |> redirect(to: Routes.html_content_template_path(conn, :show, template))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", template: template, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    template = Content.get_template!(id)
    {:ok, _template} = Content.delete_template(template)

    conn
    |> put_flash(:info, "Template deleted successfully.")
    |> redirect(to: Routes.html_content_template_path(conn, :index))
  end
end
