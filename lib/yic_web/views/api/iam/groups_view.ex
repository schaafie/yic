defmodule YicWeb.Api.Iam.GroupsView do
  use YicWeb, :view
  alias YicWeb.Api.Iam.GroupsView

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, GroupsView, "groups.json")}
  end

  def render("show.json", %{groups: groups}) do
    %{data: render_one(groups, GroupsView, "groups.json")}
  end

  def render("groups.json", %{groups: groups}) do
    %{
      id: groups.id,
      name: groups.name,
      comment: groups.comment
    }
  end
end
