defmodule YicWeb.Html.Tokens.TokenController do
  use YicWeb, :controller

  alias Yic.Flows
  alias Yic.Flows.Token

  def index(conn, _params) do
    tokens = Flows.list_tokens()
    render(conn, "index.html", tokens: tokens)
  end

  def new(conn, _params) do
    changeset = Flows.change_token(%Token{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"token" => token_params}) do
    case Flows.create_token(token_params) do
      {:ok, token} ->
        conn
        |> put_flash(:info, "Token created successfully.")
        |> redirect(to: Routes.html_tokens_token_path(conn, :show, token))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    token = Flows.get_token!(id)
    render(conn, "show.html", token: token)
  end

  def edit(conn, %{"id" => id}) do
    token = Flows.get_token!(id)
    changeset = Flows.change_token(token)
    render(conn, "edit.html", token: token, changeset: changeset)
  end

  def update(conn, %{"id" => id, "token" => token_params}) do
    token = Flows.get_token!(id)

    case Flows.update_token(token, token_params) do
      {:ok, token} ->
        conn
        |> put_flash(:info, "Token updated successfully.")
        |> redirect(to: Routes.html_tokens_token_path(conn, :show, token))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", token: token, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    token = Flows.get_token!(id)
    {:ok, _token} = Flows.delete_token(token)

    conn
    |> put_flash(:info, "Token deleted successfully.")
    |> redirect(to: Routes.html_tokens_token_path(conn, :index))
  end
end
