defmodule Yic.Iam do
  @moduledoc """
  The Iam context.
  """

  import Ecto.Query, warn: false
  alias Yic.Repo

  alias Yic.Iam.{Account, AccountToken, AccountNotifier}

  ## Database getters

  @doc """
  Gets a account by email.

  ## Examples

      iex> get_account_by_email("foo@example.com")
      %Account{}

      iex> get_account_by_email("unknown@example.com")
      nil

  """
  # def get_account_by_email(email) when is_binary(email) do
  #   Repo.get_by(Account, email: email)
  # end

  def get_account_by_login(login) when is_binary(login) do
    Repo.get_by(Account, login: login)
  end

  @doc """
  Gets a account by email and password.

  ## Examples

      iex> get_account_by_email_and_password("foo@example.com", "correct_password")
      %Account{}

      iex> get_account_by_email_and_password("foo@example.com", "invalid_password")
      nil

  """
  # def get_account_by_email_and_password(email, password)
  #     when is_binary(email) and is_binary(password) do
  #   account = Repo.get_by(Account, email: email)
  #   if Account.valid_password?(account, password), do: account
  # end

  def get_account_by_login_and_password(login, password)
      when is_binary(login) and is_binary(password) do
    account = Repo.get_by(Account, login: login)
    if Account.valid_password?(account, password), do: account
  end


  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  ## Account registration

  @doc """
  Registers a account.

  ## Examples

      iex> register_account(%{field: value})
      {:ok, %Account{}}

      iex> register_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_account(attrs) do
    %Account{}
    |> Account.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account_registration(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account_registration(%Account{} = account, attrs \\ %{}) do
    Account.registration_changeset(account, attrs, hash_password: false)
  end

  @doc """
  Delivers the update email instructions to the given account.

  ## Examples

      iex> deliver_update_email_instructions(account, current_email, &Routes.account_update_email_url(conn, :edit, &1))
      {:ok, %{to: ..., body: ...}}

  """

  def deliver_update_email_instructions(%Account{} = account, current_email, update_email_url_fun)
      when is_function(update_email_url_fun, 1) do
    {encoded_token, account_token} = AccountToken.build_email_token(account, "change:#{current_email}")

    Repo.insert!(account_token)
    AccountNotifier.deliver_update_email_instructions(account, update_email_url_fun.(encoded_token))
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the account password.

  ## Examples

      iex> change_account_password(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account_password(account, attrs \\ %{}) do
    Account.password_changeset(account, attrs, hash_password: false)
  end

  @doc """
  Updates the account password.

  ## Examples

      iex> update_account_password(account, "valid password", %{password: ...})
      {:ok, %Account{}}

      iex> update_account_password(account, "invalid password", %{password: ...})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_password(account, password, attrs) do
    changeset =
      account
      |> Account.password_changeset(attrs)
      |> Account.validate_current_password(password)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, changeset)
    |> Ecto.Multi.delete_all(:tokens, AccountToken.account_and_contexts_query(account, :all))
    |> Repo.transaction()
    |> case do
      {:ok, %{account: account}} -> {:ok, account}
      {:error, :account, changeset, _} -> {:error, changeset}
    end
  end

  ## Session

  @doc """
  Generates a session token.
  """
  def generate_account_session_token(account) do
    {token, account_token} = AccountToken.build_session_token(account)
    Repo.insert!(account_token)
    token
  end

  @doc """
  Gets the account with the given signed token.
  """
  def get_account_by_session_token(token) do
    {:ok, query} = AccountToken.verify_session_token_query(token)
    Repo.one(query)
  end

  @doc """
  Deletes the signed token with the given context.
  """
  def delete_session_token(token) do
    Repo.delete_all(AccountToken.token_and_context_query(token, "session"))
    :ok
  end

  ## Confirmation

  @doc """
  Delivers the confirmation email instructions to the given account.

  ## Examples

      iex> deliver_account_confirmation_instructions(account, &Routes.account_confirmation_url(conn, :edit, &1))
      {:ok, %{to: ..., body: ...}}

      iex> deliver_account_confirmation_instructions(confirmed_account, &Routes.account_confirmation_url(conn, :edit, &1))
      {:error, :already_confirmed}

  """
  def deliver_account_confirmation_instructions(%Account{} = account, confirmation_url_fun)
      when is_function(confirmation_url_fun, 1) do
    if account.confirmed_at do
      {:error, :already_confirmed}
    else
      {encoded_token, account_token} = AccountToken.build_email_token(account, "confirm")
      Repo.insert!(account_token)
      AccountNotifier.deliver_confirmation_instructions(account, confirmation_url_fun.(encoded_token))
    end
  end

  @doc """
  Confirms a account by the given token.

  If the token matches, the account account is marked as confirmed
  and the token is deleted.
  """
  def confirm_account(token) do
    with {:ok, query} <- AccountToken.verify_email_token_query(token, "confirm"),
         %Account{} = account <- Repo.one(query),
         {:ok, %{account: account}} <- Repo.transaction(confirm_account_multi(account)) do
      {:ok, account}
    else
      _ -> :error
    end
  end

  defp confirm_account_multi(account) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, Account.confirm_changeset(account))
    |> Ecto.Multi.delete_all(:tokens, AccountToken.account_and_contexts_query(account, ["confirm"]))
  end

  ## Reset password

  @doc """
  Delivers the reset password email to the given account.

  ## Examples

      iex> deliver_account_reset_password_instructions(account, &Routes.account_reset_password_url(conn, :edit, &1))
      {:ok, %{to: ..., body: ...}}

  """
  def deliver_account_reset_password_instructions(%Account{} = account, reset_password_url_fun)
      when is_function(reset_password_url_fun, 1) do
    {encoded_token, account_token} = AccountToken.build_email_token(account, "reset_password")
    Repo.insert!(account_token)
    AccountNotifier.deliver_reset_password_instructions(account, reset_password_url_fun.(encoded_token))
  end

  @doc """
  Gets the account by reset password token.

  ## Examples

      iex> get_account_by_reset_password_token("validtoken")
      %Account{}

      iex> get_account_by_reset_password_token("invalidtoken")
      nil

  """
  def get_account_by_reset_password_token(token) do
    with {:ok, query} <- AccountToken.verify_email_token_query(token, "reset_password"),
         %Account{} = account <- Repo.one(query) do
      account
    else
      _ -> nil
    end
  end

  @doc """
  Resets the account password.

  ## Examples

      iex> reset_account_password(account, %{password: "new long password", password_confirmation: "new long password"})
      {:ok, %Account{}}

      iex> reset_account_password(account, %{password: "valid", password_confirmation: "not the same"})
      {:error, %Ecto.Changeset{}}

  """
  def reset_account_password(account, attrs) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:account, Account.password_changeset(account, attrs))
    |> Ecto.Multi.delete_all(:tokens, AccountToken.account_and_contexts_query(account, :all))
    |> Repo.transaction()
    |> case do
      {:ok, %{account: account}} -> {:ok, account}
      {:error, :account, changeset, _} -> {:error, changeset}
    end
  end

  def list_accounts do
    Repo.all(Account)
  end
  
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end


  alias Yic.Iam.Users

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%Users{}, ...]

  """
  def list_users do
    Repo.all(Users)
  end

  @doc """
  Gets a single users.

  Raises `Ecto.NoResultsError` if the Users does not exist.

  ## Examples

      iex> get_users!(123)
      %Users{}

      iex> get_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_users!(id), do: Repo.get!(Users, id)

  @doc """
  Creates a users.

  ## Examples

      iex> create_users(%{field: value})
      {:ok, %Users{}}

      iex> create_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_users(attrs \\ %{}) do
    %Users{}
    |> Users.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a users.

  ## Examples

      iex> update_users(users, %{field: new_value})
      {:ok, %Users{}}

      iex> update_users(users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_users(%Users{} = users, attrs) do
    users
    |> Users.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a users.

  ## Examples

      iex> delete_users(users)
      {:ok, %Users{}}

      iex> delete_users(users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_users(%Users{} = users) do
    Repo.delete(users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking users changes.

  ## Examples

      iex> change_users(users)
      %Ecto.Changeset{data: %Users{}}

  """
  def change_users(%Users{} = users, attrs \\ %{}) do
    Users.changeset(users, attrs)
  end

  alias Yic.Iam.Roles

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Roles{}, ...]

  """
  def list_roles do
    Repo.all(Roles)
  end

  @doc """
  Gets a single roles.

  Raises `Ecto.NoResultsError` if the Roles does not exist.

  ## Examples

      iex> get_roles!(123)
      %Roles{}

      iex> get_roles!(456)
      ** (Ecto.NoResultsError)

  """
  def get_roles!(id), do: Repo.get!(Roles, id)

  @doc """
  Creates a roles.

  ## Examples

      iex> create_roles(%{field: value})
      {:ok, %Roles{}}

      iex> create_roles(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roles(attrs \\ %{}) do
    %Roles{}
    |> Roles.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a roles.

  ## Examples

      iex> update_roles(roles, %{field: new_value})
      {:ok, %Roles{}}

      iex> update_roles(roles, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_roles(%Roles{} = roles, attrs) do
    roles
    |> Roles.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a roles.

  ## Examples

      iex> delete_roles(roles)
      {:ok, %Roles{}}

      iex> delete_roles(roles)
      {:error, %Ecto.Changeset{}}

  """
  def delete_roles(%Roles{} = roles) do
    Repo.delete(roles)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roles changes.

  ## Examples

      iex> change_roles(roles)
      %Ecto.Changeset{data: %Roles{}}

  """
  def change_roles(%Roles{} = roles, attrs \\ %{}) do
    Roles.changeset(roles, attrs)
  end

  alias Yic.Iam.Groups

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Groups{}, ...]

  """
  def list_groups do
    Repo.all(Groups)
  end

  @doc """
  Gets a single groups.

  Raises `Ecto.NoResultsError` if the Groups does not exist.

  ## Examples

      iex> get_groups!(123)
      %Groups{}

      iex> get_groups!(456)
      ** (Ecto.NoResultsError)

  """
  def get_groups!(id), do: Repo.get!(Groups, id)

  @doc """
  Creates a groups.

  ## Examples

      iex> create_groups(%{field: value})
      {:ok, %Groups{}}

      iex> create_groups(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_groups(attrs \\ %{}) do
    %Groups{}
    |> Groups.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a groups.

  ## Examples

      iex> update_groups(groups, %{field: new_value})
      {:ok, %Groups{}}

      iex> update_groups(groups, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_groups(%Groups{} = groups, attrs) do
    groups
    |> Groups.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a groups.

  ## Examples

      iex> delete_groups(groups)
      {:ok, %Groups{}}

      iex> delete_groups(groups)
      {:error, %Ecto.Changeset{}}

  """
  def delete_groups(%Groups{} = groups) do
    Repo.delete(groups)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking groups changes.

  ## Examples

      iex> change_groups(groups)
      %Ecto.Changeset{data: %Groups{}}

  """
  def change_groups(%Groups{} = groups, attrs \\ %{}) do
    Groups.changeset(groups, attrs)
  end

  alias Yic.Iam.System

  @doc """
  Returns the list of systems.

  ## Examples

      iex> list_systems()
      [%System{}, ...]

  """
  def list_systems do
    Repo.all(System)
  end

  @doc """
  Gets a single system.

  Raises `Ecto.NoResultsError` if the System does not exist.

  ## Examples

      iex> get_system!(123)
      %System{}

      iex> get_system!(456)
      ** (Ecto.NoResultsError)

  """
  def get_system!(id), do: Repo.get!(System, id)

  @doc """
  Creates a system.

  ## Examples

      iex> create_system(%{field: value})
      {:ok, %System{}}

      iex> create_system(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_system(attrs \\ %{}) do
    %System{}
    |> System.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a system.

  ## Examples

      iex> update_system(system, %{field: new_value})
      {:ok, %System{}}

      iex> update_system(system, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_system(%System{} = system, attrs) do
    system
    |> System.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a system.

  ## Examples

      iex> delete_system(system)
      {:ok, %System{}}

      iex> delete_system(system)
      {:error, %Ecto.Changeset{}}

  """
  def delete_system(%System{} = system) do
    Repo.delete(system)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking system changes.

  ## Examples

      iex> change_system(system)
      %Ecto.Changeset{data: %System{}}

  """
  def change_system(%System{} = system, attrs \\ %{}) do
    System.changeset(system, attrs)
  end

  alias Yic.Iam.Action

  @doc """
  Returns the list of actions.

  ## Examples

      iex> list_actions()
      [%Action{}, ...]

  """
  def list_actions do
    Repo.all(Action)
  end

  @doc """
  Gets a single action.

  Raises `Ecto.NoResultsError` if the Action does not exist.

  ## Examples

      iex> get_action!(123)
      %Action{}

      iex> get_action!(456)
      ** (Ecto.NoResultsError)

  """
  def get_action!(id), do: Repo.get!(Action, id)

  @doc """
  Creates a action.

  ## Examples

      iex> create_action(%{field: value})
      {:ok, %Action{}}

      iex> create_action(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_action(attrs \\ %{}) do
    %Action{}
    |> Action.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a action.

  ## Examples

      iex> update_action(action, %{field: new_value})
      {:ok, %Action{}}

      iex> update_action(action, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_action(%Action{} = action, attrs) do
    action
    |> Action.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a action.

  ## Examples

      iex> delete_action(action)
      {:ok, %Action{}}

      iex> delete_action(action)
      {:error, %Ecto.Changeset{}}

  """
  def delete_action(%Action{} = action) do
    Repo.delete(action)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking action changes.

  ## Examples

      iex> change_action(action)
      %Ecto.Changeset{data: %Action{}}

  """
  def change_action(%Action{} = action, attrs \\ %{}) do
    Action.changeset(action, attrs)
  end

  alias Yic.Iam.Allow

  @doc """
  Returns the list of allows.

  ## Examples

      iex> list_allows()
      [%Allow{}, ...]

  """
  def list_allows do
    Repo.all(Allow)
  end

  @doc """
  Gets a single allow.

  Raises `Ecto.NoResultsError` if the Allow does not exist.

  ## Examples

      iex> get_allow!(123)
      %Allow{}

      iex> get_allow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_allow!(id), do: Repo.get!(Allow, id)

  @doc """
  Creates a allow.

  ## Examples

      iex> create_allow(%{field: value})
      {:ok, %Allow{}}

      iex> create_allow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_allow(attrs \\ %{}) do
    %Allow{}
    |> Allow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a allow.

  ## Examples

      iex> update_allow(allow, %{field: new_value})
      {:ok, %Allow{}}

      iex> update_allow(allow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_allow(%Allow{} = allow, attrs) do
    allow
    |> Allow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a allow.

  ## Examples

      iex> delete_allow(allow)
      {:ok, %Allow{}}

      iex> delete_allow(allow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_allow(%Allow{} = allow) do
    Repo.delete(allow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking allow changes.

  ## Examples

      iex> change_allow(allow)
      %Ecto.Changeset{data: %Allow{}}

  """
  def change_allow(%Allow{} = allow, attrs \\ %{}) do
    Allow.changeset(allow, attrs)
  end

  alias Yic.Iam.Denie

  @doc """
  Returns the list of denies.

  ## Examples

      iex> list_denies()
      [%Denie{}, ...]

  """
  def list_denies do
    Repo.all(Denie)
  end

  @doc """
  Gets a single denie.

  Raises `Ecto.NoResultsError` if the Denie does not exist.

  ## Examples

      iex> get_denie!(123)
      %Denie{}

      iex> get_denie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_denie!(id), do: Repo.get!(Denie, id)

  @doc """
  Creates a denie.

  ## Examples

      iex> create_denie(%{field: value})
      {:ok, %Denie{}}

      iex> create_denie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_denie(attrs \\ %{}) do
    %Denie{}
    |> Denie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a denie.

  ## Examples

      iex> update_denie(denie, %{field: new_value})
      {:ok, %Denie{}}

      iex> update_denie(denie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_denie(%Denie{} = denie, attrs) do
    denie
    |> Denie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a denie.

  ## Examples

      iex> delete_denie(denie)
      {:ok, %Denie{}}

      iex> delete_denie(denie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_denie(%Denie{} = denie) do
    Repo.delete(denie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking denie changes.

  ## Examples

      iex> change_denie(denie)
      %Ecto.Changeset{data: %Denie{}}

  """
  def change_denie(%Denie{} = denie, attrs \\ %{}) do
    Denie.changeset(denie, attrs)
  end
end
