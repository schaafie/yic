defmodule YicWeb.Html.Iam.AccountController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Account

  def index(conn, _params) do
    accounts = Iam.list_accounts()
    render(conn, "index.html", accounts: accounts)
  end

  def new(conn, _params) do
    changeset = Iam.change_account(%Account{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    case Iam.create_action(account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> redirect(to: Routes.html_iam_account_path(conn, :show, account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    action = Iam.get_account!(id)
    render(conn, "show.html", action: action)
  end

  def edit(conn, %{"id" => id}) do
    account = Iam.get_account!(id)
    changeset = Iam.change_account(account)
    render(conn, "edit.html", account: account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "action" => account_params}) do
    account = Iam.get_account!(id)

    case Iam.update_account(account, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account updated successfully.")
        |> redirect(to: Routes.html_iam_account_path(conn, :show, account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", account: account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Iam.get_account!(id)
    {:ok, _account} = Iam.delete_account(account)

    conn
    |> put_flash(:info, "Account deleted successfully.")
    |> redirect(to: Routes.html_iam_account_path(conn, :index))
  end
end
