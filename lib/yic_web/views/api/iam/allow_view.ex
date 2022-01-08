defmodule YicWeb.Api.Iam.AllowView do
  use YicWeb, :view
  alias YicWeb.Api.Iam.AllowView

  def render("index.json", %{allows: allows}) do
    %{data: render_many(allows, AllowView, "allow.json")}
  end

  def render("show.json", %{allow: allow}) do
    %{data: render_one(allow, AllowView, "allow.json")}
  end

  def render("allow.json", %{allow: allow}) do
    %{
      id: allow.id
    }
  end
end
