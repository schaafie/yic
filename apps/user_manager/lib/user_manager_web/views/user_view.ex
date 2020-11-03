defmodule UserManagerWeb.UserView do
  use UserManagerWeb, :view
  alias UserManagerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      login: user.login,
      password: user.password}
  end
end
