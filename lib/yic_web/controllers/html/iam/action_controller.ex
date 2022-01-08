defmodule YicWeb.Html.Iam.ActionController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Action

  def index(conn, _params) do
    actions = Iam.list_actions()
    render(conn, "index.html", actions: actions)
  end

  def new(conn, _params) do
    changeset = Iam.change_action(%Action{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"action" => action_params}) do
    case Iam.create_action(action_params) do
      {:ok, action} ->
        conn
        |> put_flash(:info, "Action created successfully.")
        |> redirect(to: Routes.html_iam_action_path(conn, :show, action))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    action = Iam.get_action!(id)
    render(conn, "show.html", action: action)
  end

  def edit(conn, %{"id" => id}) do
    action = Iam.get_action!(id)
    changeset = Iam.change_action(action)
    render(conn, "edit.html", action: action, changeset: changeset)
  end

  def update(conn, %{"id" => id, "action" => action_params}) do
    action = Iam.get_action!(id)

    case Iam.update_action(action, action_params) do
      {:ok, action} ->
        conn
        |> put_flash(:info, "Action updated successfully.")
        |> redirect(to: Routes.html_iam_action_path(conn, :show, action))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", action: action, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    action = Iam.get_action!(id)
    {:ok, _action} = Iam.delete_action(action)

    conn
    |> put_flash(:info, "Action deleted successfully.")
    |> redirect(to: Routes.html_iam_action_path(conn, :index))
  end
end
