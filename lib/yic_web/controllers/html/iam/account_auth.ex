defmodule YicWeb.Html.Iam.AccountAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Yic.Iam
  alias YicWeb.Router.Helpers, as: Routes

  # Make the remember me cookie valid for 60 days.
  # If you want bump or reduce this value, also change
  # the token expiry itself in AccountToken.
  @max_age 60 * 60 * 24 * 60
  @remember_me_cookie "_yic_web_account_remember_me"
  @remember_me_options [sign: true, max_age: @max_age, same_site: "Lax"]

  @doc """
  Logs the account in.

  It renews the session ID and clears the whole session
  to avoid fixation attacks. See the renew_session
  function to customize this behaviour.

  It also sets a `:live_socket_id` key in the session,
  so LiveView sessions are identified and automatically
  disconnected on log out. The line can be safely removed
  if you are not using LiveView.
  """
  def log_in_account(conn, account, params \\ %{}) do
    token = Iam.generate_account_session_token(account)
    account_return_to = get_session(conn, :account_return_to)

    conn
    |> renew_session()
    |> put_session(:account_token, token)
    |> put_session(:live_socket_id, "accounts_sessions:#{Base.url_encode64(token)}")
    |> maybe_write_remember_me_cookie(token, params)
    |> redirect(to: account_return_to || signed_in_path(conn))
  end

  defp maybe_write_remember_me_cookie(conn, token, %{"remember_me" => "true"}) do
    put_resp_cookie(conn, @remember_me_cookie, token, @remember_me_options)
  end

  defp maybe_write_remember_me_cookie(conn, _token, _params) do
    conn
  end

  # This function renews the session ID and erases the whole
  # session to avoid fixation attacks. If there is any data
  # in the session you may want to preserve after log in/log out,
  # you must explicitly fetch the session data before clearing
  # and then immediately set it after clearing, for example:
  #
  #     defp renew_session(conn) do
  #       preferred_locale = get_session(conn, :preferred_locale)
  #
  #       conn
  #       |> configure_session(renew: true)
  #       |> clear_session()
  #       |> put_session(:preferred_locale, preferred_locale)
  #     end
  #
  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end

  @doc """
  Logs the account out.

  It clears all session data for safety. See renew_session.
  """
  def log_out_account(conn) do
    account_token = get_session(conn, :account_token)
    account_token && Iam.delete_session_token(account_token)

    if live_socket_id = get_session(conn, :live_socket_id) do
      YicWeb.Endpoint.broadcast(live_socket_id, "disconnect", %{})
    end

    conn
    |> renew_session()
    |> delete_resp_cookie(@remember_me_cookie)
    |> redirect(to: "/html/iam/accounts")
  end

  @doc """
  Authenticates the account by looking into the session
  and remember me token.
  """
  def fetch_current_account(conn, _opts) do
    {account_token, conn} = ensure_account_token(conn)
    account = account_token && Iam.get_account_by_session_token(account_token)
    assign(conn, :current_account, account)
  end

  defp ensure_account_token(conn) do
    if account_token = get_session(conn, :account_token) do
      {account_token, conn}
    else
      conn = fetch_cookies(conn, signed: [@remember_me_cookie])

      if account_token = conn.cookies[@remember_me_cookie] do
        {account_token, put_session(conn, :account_token, account_token)}
      else
        {nil, conn}
      end
    end
  end

  @doc """
  Fetch user info linked to JWT .
  """
  def fetch_current_account_api(conn, _opts) do
    account = conn.private.guardian_default_resource
    assign(conn, :current_account, account)
  end

  @doc """
  Used for routes that require the account to not be authenticated.
  """
  def redirect_if_account_is_authenticated(conn, _opts) do
    if conn.assigns[:current_account] do
      conn
      |> redirect(to: signed_in_path(conn))
      |> halt()
    else
      conn
    end
  end

  @doc """
  Used for routes that require the account to be authenticated.

  If you want to enforce the account email is confirmed before
  they use the application at all, here would be a good place.
  """
  def require_authenticated_account(conn, _opts) do
    if conn.assigns[:current_account] do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access this page.")
      |> maybe_store_return_to()
      |> redirect(to: Routes.html_iam_account_session_path(conn, :new))
      |> halt()
    end
  end

  defp maybe_store_return_to(%{method: "GET"} = conn) do
    put_session(conn, :account_return_to, current_path(conn))
  end

  defp maybe_store_return_to(conn), do: conn

  defp signed_in_path(_conn), do: "/"
end
