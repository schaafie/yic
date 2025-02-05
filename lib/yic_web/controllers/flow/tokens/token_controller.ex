defmodule YicWeb.Flow.Tokens.TokenController do
  use YicWeb, :controller

  alias Yic.Flows
  alias Yic.Flows.Token

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    tokens = Flows.list_tokens()
    render(conn, "index.json", tokens: tokens)
  end

  def create(conn, %{"token" => token_params}) do
    with {:ok, %Token{} = token} <- Flows.create_token(token_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.flow_tokens_token_path(conn, :show, token))
      |> render("show.json", token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    token = Flows.get_token!(id)
    render(conn, "show.json", token: token)
  end

  def update(conn, %{"id" => id, "token" => token_params}) do
    token = Flows.get_token!(id)

    with {:ok, %Token{} = token} <- Flows.update_token(token, token_params) do
      render(conn, "show.json", token: token)
    end
  end

  def delete(conn, %{"id" => id}) do
    token = Flows.get_token!(id)

    with {:ok, %Token{}} <- Flows.delete_token(token) do
      send_resp(conn, :no_content, "")
    end
  end
end
