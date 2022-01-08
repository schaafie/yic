defmodule YicWeb.Api.Iam.RolesView do
  use YicWeb, :view
  alias YicWeb.Api.Iam.RolesView

  def render("index.json", %{roles: roles}) do
    %{data: render_many(roles, RolesView, "roles.json")}
  end

  def render("show.json", %{roles: roles}) do
    %{data: render_one(roles, RolesView, "roles.json")}
  end

  def render("roles.json", %{roles: roles}) do
    %{
      id: roles.id,
      name: roles.name,
      description: roles.description
    }
  end
end
