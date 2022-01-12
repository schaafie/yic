defmodule YicWeb.Html.Iam.AccountSettingsController do
  use YicWeb, :controller

  alias Yic.Iam
  alias YicWeb.Html.Iam.AccountAuth

  # plug :assign_email_and_password_changesets
  plug :assign_password_changesets

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  # def update(conn, %{"action" => "update_email"} = params) do
  #   %{"current_password" => password, "account" => account_params} = params
  #   account = conn.assigns.current_account

  #   case Iam.apply_account_email(account, password, account_params) do
  #     {:ok, applied_account} ->
  #       Iam.deliver_update_email_instructions(
  #         applied_account,
  #         account.email,
  #         &Routes.html_iam_account_settings_url(conn, :confirm_email, &1)
  #       )

  #       conn
  #       |> put_flash(
  #         :info,
  #         "A link to confirm your email change has been sent to the new address."
  #       )
  #       |> redirect(to: Routes.html_iam_account_settings_path(conn, :edit))

  #     {:error, changeset} ->
  #       render(conn, "edit.html", email_changeset: changeset)
  #   end
  # end

  def update(conn, %{"action" => "update_password"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    account = conn.assigns.current_account

    case Iam.update_account_password(account, password, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Password updated successfully.")
        |> put_session(:account_return_to, Routes.html_iam_account_settings_path(conn, :edit))
        |> AccountAuth.log_in_account(account)

      {:error, changeset} ->
        render(conn, "edit.html", password_changeset: changeset)
    end
  end

  # def confirm_email(conn, %{"token" => token}) do
  #   case Iam.update_account_email(conn.assigns.current_account, token) do
  #     :ok ->
  #       conn
  #       |> put_flash(:info, "Email changed successfully.")
  #       |> redirect(to: Routes.html_iam_account_settings_path(conn, :edit))

  #     :error ->
  #       conn
  #       |> put_flash(:error, "Email change link is invalid or it has expired.")
  #       |> redirect(to: Routes.html_iam_account_settings_path(conn, :edit))
  #   end
  # end

  defp assign_password_changesets(conn, _opts) do
    account = conn.assigns.current_account

    conn
    |> assign(:password_changeset, Iam.change_account_password(account))
  end

  # defp assign_email_and_password_changesets(conn, _opts) do
  #   account = conn.assigns.current_account

  #   conn
  #   |> assign(:email_changeset, Iam.change_account_email(account))
  #   |> assign(:password_changeset, Iam.change_account_password(account))
  # end
end
