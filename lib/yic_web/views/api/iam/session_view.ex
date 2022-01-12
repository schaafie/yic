defmodule YicWeb.Api.Iam.SessionView do
    use YicWeb, :view
  
    def render("create.json", %{account: account, jwt: jwt}) do
      %{
        status: :ok,
        data: %{
          token: jwt,
          login: account.login
        },
        message: "You are successfully logged in! Add this token to authorization header to make authorized requests."
      }
    end
  
    def render("error.json", %{message: message}) do
      %{
        status: :not_found,
        data: %{},
        message: message
      }
    end
  end