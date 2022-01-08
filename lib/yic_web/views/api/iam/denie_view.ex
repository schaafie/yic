defmodule YicWeb.Api.Iam.DenieView do
  use YicWeb, :view
  alias YicWeb.Api.Iam.DenieView

  def render("index.json", %{denies: denies}) do
    %{data: render_many(denies, DenieView, "denie.json")}
  end

  def render("show.json", %{denie: denie}) do
    %{data: render_one(denie, DenieView, "denie.json")}
  end

  def render("denie.json", %{denie: denie}) do
    %{
      id: denie.id
    }
  end
end
