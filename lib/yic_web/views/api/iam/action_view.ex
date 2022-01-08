defmodule YicWeb.Api.Iam.ActionView do
  use YicWeb, :view
  alias YicWeb.Api.Iam.ActionView

  def render("index.json", %{actions: actions}) do
    %{data: render_many(actions, ActionView, "action.json")}
  end

  def render("show.json", %{action: action}) do
    %{data: render_one(action, ActionView, "action.json")}
  end

  def render("action.json", %{action: action}) do
    %{
      id: action.id,
      name: action.name,
      comment: action.comment,
      url: action.url
    }
  end
end
