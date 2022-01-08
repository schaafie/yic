defmodule YicWeb.Html.Forms.FormController do
  use YicWeb, :controller

  alias Yic.Forms
  alias Yic.Forms.Form

  def index(conn, _params) do
    forms = Forms.list_forms()
    render(conn, "index.html", forms: forms)
  end

  def new(conn, _params) do
    changeset = Forms.change_form(%Form{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"form" => form_params}) do
    case Forms.create_form(form_params) do
      {:ok, form} ->
        conn
        |> put_flash(:info, "Form created successfully.")
        |> redirect(to: Routes.html_forms_form_path(conn, :show, form))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    form = Forms.get_form!(id)
    render(conn, "show.html", form: form)
  end

  def edit(conn, %{"id" => id}) do
    form = Forms.get_form!(id)
    changeset = Forms.change_form(form)
    render(conn, "edit.html", form: form, changeset: changeset)
  end

  def update(conn, %{"id" => id, "form" => form_params}) do
    form = Forms.get_form!(id)

    case Forms.update_form(form, form_params) do
      {:ok, form} ->
        conn
        |> put_flash(:info, "Form updated successfully.")
        |> redirect(to: Routes.html_forms_form_path(conn, :show, form))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", form: form, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    form = Forms.get_form!(id)
    {:ok, _form} = Forms.delete_form(form)

    conn
    |> put_flash(:info, "Form deleted successfully.")
    |> redirect(to: Routes.html_forms_form_path(conn, :index))
  end
end
