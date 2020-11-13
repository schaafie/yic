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

  def render("definition.json", _args) do
    %{
      elements: [
        %{ name: "id", type: "integer", validations: [], required: "true" },
        %{ name: "firstname", type: "text", validations: [], required: "true" },
        %{ name: "lastname", type: "text", validations: [], required: "true" },
        %{ name: "email", type: "email", validations: [], required: "true" },
        %{ name: "login", type: "text", validations: [], required: "true" },
        %{ name: "password", type: "text", validations: [], required: "true" },
      ],
      globalValidations: [],
    }
  end
end
