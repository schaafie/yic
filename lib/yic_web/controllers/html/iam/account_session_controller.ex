defmodule YicWeb.Html.Iam.AccountSessionController do
  use YicWeb, :controller

  alias Yic.Iam
  alias YicWeb.Html.Iam.AccountAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"account" => account_params}) do
    %{"login" => login, "password" => password} = account_params

    if account = Iam.get_account_by_login_and_password(login, password) do
      AccountAuth.log_in_account(conn, account, account_params)
    else
      render(conn, "new.html", error_message: "Invalid login or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> AccountAuth.log_out_account()
  end
end
