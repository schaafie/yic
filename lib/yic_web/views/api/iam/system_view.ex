defmodule YicWeb.Api.Iam.SystemView do
  use YicWeb, :view
  alias YicWeb.Api.Iam.SystemView

  def render("index.json", %{systems: systems}) do
    %{data: render_many(systems, SystemView, "system.json")}
  end

  def render("show.json", %{system: system}) do
    %{data: render_one(system, SystemView, "system.json")}
  end

  def render("system.json", %{system: system}) do
    %{
      id: system.id,
      name: system.name,
      comment: system.comment,
      host: system.host
    }
  end
end
