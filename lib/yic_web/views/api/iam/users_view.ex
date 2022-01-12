defmodule YicWeb.Api.Iam.UsersView do
  use YicWeb, :view
  alias YicWeb.Api.Iam.UsersView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UsersView, "users.json")}
  end

  def render("show.json", %{users: users}) do
    %{data: render_one(users, UsersView, "users.json")}
  end

  def render("users.json", %{users: users}) do
    %{
      id: users.id,
      firstname: users.firstname,
      lastname: users.lastname,
      email: users.email
    }
  end
end
