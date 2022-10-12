defmodule YicWeb.Api.Iam.SessionController do
    use YicWeb, :controller
  
    alias Yic.Iam.Account
    alias Yic.Iam
    alias Yic.Guardian
  
    def create(conn, %{"email" => nil}) do
      conn
      |> put_status(401)
      |> render("error.json", message: "User could not be authenticated")
    end
  
    def create(conn, %{"login" => login, "password" => password}) do
      if (is_nil(login) or is_nil(password)) do
        conn
        |> put_status(401)
        |> render("error.json", message: "User could not be authenticated")
      else
        case Iam.get_account_by_login_and_password(login, password) do 
          %Account{} = account ->
            {:ok, jwt, _full_claims} = Guardian.encode_and_sign(account, %{}, ttl: {1, :hour})
            conn
            |> render("create.json", account: account, jwt: jwt)
          nil ->
            conn
            |> put_status(401)
            |> render("error.json", message: "User could not be authenticated")
        end  
      end
    end
  end