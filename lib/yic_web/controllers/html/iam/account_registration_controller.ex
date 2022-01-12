defmodule YicWeb.Html.Iam.AccountRegistrationController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Account
  alias YicWeb.Html.Iam.AccountAuth

  def new(conn, _params) do
    changeset = Iam.change_account_registration(%Account{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    case Iam.register_account(account_params) do
      {:ok, account} ->
        {:ok, _} =
          Iam.deliver_account_confirmation_instructions(
            account,
            &Routes.html_iam_account_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "Account created successfully.")
        |> AccountAuth.log_in_account(account)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
