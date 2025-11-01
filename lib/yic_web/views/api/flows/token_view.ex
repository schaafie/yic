defmodule YicWeb.Api.Flows.TokenView do
  use YicWeb, :view
  alias YicWeb.Api.Flows.TokenView

  def render("index.json", %{tokens: tokens}) do
    %{data: render_many(tokens, TokenView, "token.json")}
  end

  def render("show.json", %{token: token}) do
    %{data: render_one(token, TokenView, "token.json")}
  end

  def render("token.json", %{token: token}) do
    %{
      id: token.id,
      current_task: token.current_task,
      can_do: token.can_do
    }
  end
end
