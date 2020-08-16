defmodule ApiWeb.ApiView do
  use ApiWeb, :view
  alias ApiWeb.ApiView

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user} ) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("show.json", %{set: [user: user, userroles: userroles]} ) do
    %{data: render_one(user, UserView, "user.json")
      |> Map.put_new( :userroles, render_many( userroles, UserView, "userrole.json", as: :userrole ))
    }
  end

  def render("userrole.json", %{userrole: userrole}) do
    %{userid: userrole.userid,
      memberid: userrole.memberid,
      roleid: userrole.id,
      rolename: userrole.name}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      login: user.login,
      email: user.email,
      password_hash: user.password_hash}
  end
end
