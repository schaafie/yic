defmodule YicWeb.Html.Iam.AccountResetPasswordController do
  use YicWeb, :controller

  alias Yic.Iam

  plug :get_account_by_reset_password_token when action in [:edit, :update]

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"account" => %{"login" => login}}) do
    if account = Iam.get_account_by_login(login) do
      Iam.deliver_account_reset_password_instructions(
        account,
        &Routes.html_iam_account_reset_password_url(conn, :edit, &1)
      )
    end

    conn
    |> put_flash(
      :info,
      "If your login is in our system, you will receive instructions to reset your password shortly."
    )
    |> redirect(to: "/")
  end

  def edit(conn, _params) do
    render(conn, "edit.html", changeset: Iam.change_account_password(conn.assigns.account))
  end

  # Do not log in the account after reset password to avoid a
  # leaked token giving the account access to the account.
  def update(conn, %{"account" => account_params}) do
    case Iam.reset_account_password(conn.assigns.account, account_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Password reset successfully.")
        |> redirect(to: Routes.html_iam_account_session_path(conn, :new))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  defp get_account_by_reset_password_token(conn, _opts) do
    %{"token" => token} = conn.params

    if account = Iam.get_account_by_reset_password_token(token) do
      conn |> assign(:account, account) |> assign(:token, token)
    else
      conn
      |> put_flash(:error, "Reset password link is invalid or it has expired.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
