defmodule Yic.IamTest do
  use Yic.DataCase

  alias Yic.Iam

  import Yic.IamFixtures
  alias Yic.Iam.{Account, AccountToken}

  describe "get_account_by_email/1" do
    test "does not return the account if the email does not exist" do
      refute Iam.get_account_by_email("unknown@example.com")
    end

    test "returns the account if the email exists" do
      %{id: id} = account = account_fixture()
      assert %Account{id: ^id} = Iam.get_account_by_email(account.email)
    end
  end

  describe "get_account_by_email_and_password/2" do
    test "does not return the account if the email does not exist" do
      refute Iam.get_account_by_email_and_password("unknown@example.com", "hello world!")
    end

    test "does not return the account if the password is not valid" do
      account = account_fixture()
      refute Iam.get_account_by_email_and_password(account.email, "invalid")
    end

    test "returns the account if the email and password are valid" do
      %{id: id} = account = account_fixture()

      assert %Account{id: ^id} =
               Iam.get_account_by_email_and_password(account.email, valid_account_password())
    end
  end

  describe "get_account!/1" do
    test "raises if id is invalid" do
      assert_raise Ecto.NoResultsError, fn ->
        Iam.get_account!(-1)
      end
    end

    test "returns the account with the given id" do
      %{id: id} = account = account_fixture()
      assert %Account{id: ^id} = Iam.get_account!(account.id)
    end
  end

  describe "register_account/1" do
    test "requires email and password to be set" do
      {:error, changeset} = Iam.register_account(%{})

      assert %{
               password: ["can't be blank"],
               email: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "validates email and password when given" do
      {:error, changeset} = Iam.register_account(%{email: "not valid", password: "not valid"})

      assert %{
               email: ["must have the @ sign and no spaces"],
               password: ["should be at least 12 character(s)"]
             } = errors_on(changeset)
    end

    test "validates maximum values for email and password for security" do
      too_long = String.duplicate("db", 100)
      {:error, changeset} = Iam.register_account(%{email: too_long, password: too_long})
      assert "should be at most 160 character(s)" in errors_on(changeset).email
      assert "should be at most 72 character(s)" in errors_on(changeset).password
    end

    test "validates email uniqueness" do
      %{email: email} = account_fixture()
      {:error, changeset} = Iam.register_account(%{email: email})
      assert "has already been taken" in errors_on(changeset).email

      # Now try with the upper cased email too, to check that email case is ignored.
      {:error, changeset} = Iam.register_account(%{email: String.upcase(email)})
      assert "has already been taken" in errors_on(changeset).email
    end

    test "registers accounts with a hashed password" do
      email = unique_account_email()
      {:ok, account} = Iam.register_account(valid_account_attributes(email: email))
      assert account.email == email
      assert is_binary(account.hashed_password)
      assert is_nil(account.confirmed_at)
      assert is_nil(account.password)
    end
  end

  describe "change_account_registration/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = changeset = Iam.change_account_registration(%Account{})
      assert changeset.required == [:password, :email]
    end

    test "allows fields to be set" do
      email = unique_account_email()
      password = valid_account_password()

      changeset =
        Iam.change_account_registration(
          %Account{},
          valid_account_attributes(email: email, password: password)
        )

      assert changeset.valid?
      assert get_change(changeset, :email) == email
      assert get_change(changeset, :password) == password
      assert is_nil(get_change(changeset, :hashed_password))
    end
  end

  describe "change_account_email/2" do
    test "returns a account changeset" do
      assert %Ecto.Changeset{} = changeset = Iam.change_account_email(%Account{})
      assert changeset.required == [:email]
    end
  end

  describe "apply_account_email/3" do
    setup do
      %{account: account_fixture()}
    end

    test "requires email to change", %{account: account} do
      {:error, changeset} = Iam.apply_account_email(account, valid_account_password(), %{})
      assert %{email: ["did not change"]} = errors_on(changeset)
    end

    test "validates email", %{account: account} do
      {:error, changeset} =
        Iam.apply_account_email(account, valid_account_password(), %{email: "not valid"})

      assert %{email: ["must have the @ sign and no spaces"]} = errors_on(changeset)
    end

    test "validates maximum value for email for security", %{account: account} do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        Iam.apply_account_email(account, valid_account_password(), %{email: too_long})

      assert "should be at most 160 character(s)" in errors_on(changeset).email
    end

    test "validates email uniqueness", %{account: account} do
      %{email: email} = account_fixture()

      {:error, changeset} =
        Iam.apply_account_email(account, valid_account_password(), %{email: email})

      assert "has already been taken" in errors_on(changeset).email
    end

    test "validates current password", %{account: account} do
      {:error, changeset} =
        Iam.apply_account_email(account, "invalid", %{email: unique_account_email()})

      assert %{current_password: ["is not valid"]} = errors_on(changeset)
    end

    test "applies the email without persisting it", %{account: account} do
      email = unique_account_email()
      {:ok, account} = Iam.apply_account_email(account, valid_account_password(), %{email: email})
      assert account.email == email
      assert Iam.get_account!(account.id).email != email
    end
  end

  describe "deliver_update_email_instructions/3" do
    setup do
      %{account: account_fixture()}
    end

    test "sends token through notification", %{account: account} do
      token =
        extract_account_token(fn url ->
          Iam.deliver_update_email_instructions(account, "current@example.com", url)
        end)

      {:ok, token} = Base.url_decode64(token, padding: false)
      assert account_token = Repo.get_by(AccountToken, token: :crypto.hash(:sha256, token))
      assert account_token.account_id == account.id
      assert account_token.sent_to == account.email
      assert account_token.context == "change:current@example.com"
    end
  end

  describe "update_account_email/2" do
    setup do
      account = account_fixture()
      email = unique_account_email()

      token =
        extract_account_token(fn url ->
          Iam.deliver_update_email_instructions(%{account | email: email}, account.email, url)
        end)

      %{account: account, token: token, email: email}
    end

    test "updates the email with a valid token", %{account: account, token: token, email: email} do
      assert Iam.update_account_email(account, token) == :ok
      changed_account = Repo.get!(Account, account.id)
      assert changed_account.email != account.email
      assert changed_account.email == email
      assert changed_account.confirmed_at
      assert changed_account.confirmed_at != account.confirmed_at
      refute Repo.get_by(AccountToken, account_id: account.id)
    end

    test "does not update email with invalid token", %{account: account} do
      assert Iam.update_account_email(account, "oops") == :error
      assert Repo.get!(Account, account.id).email == account.email
      assert Repo.get_by(AccountToken, account_id: account.id)
    end

    test "does not update email if account email changed", %{account: account, token: token} do
      assert Iam.update_account_email(%{account | email: "current@example.com"}, token) == :error
      assert Repo.get!(Account, account.id).email == account.email
      assert Repo.get_by(AccountToken, account_id: account.id)
    end

    test "does not update email if token expired", %{account: account, token: token} do
      {1, nil} = Repo.update_all(AccountToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])
      assert Iam.update_account_email(account, token) == :error
      assert Repo.get!(Account, account.id).email == account.email
      assert Repo.get_by(AccountToken, account_id: account.id)
    end
  end

  describe "change_account_password/2" do
    test "returns a account changeset" do
      assert %Ecto.Changeset{} = changeset = Iam.change_account_password(%Account{})
      assert changeset.required == [:password]
    end

    test "allows fields to be set" do
      changeset =
        Iam.change_account_password(%Account{}, %{
          "password" => "new valid password"
        })

      assert changeset.valid?
      assert get_change(changeset, :password) == "new valid password"
      assert is_nil(get_change(changeset, :hashed_password))
    end
  end

  describe "update_account_password/3" do
    setup do
      %{account: account_fixture()}
    end

    test "validates password", %{account: account} do
      {:error, changeset} =
        Iam.update_account_password(account, valid_account_password(), %{
          password: "not valid",
          password_confirmation: "another"
        })

      assert %{
               password: ["should be at least 12 character(s)"],
               password_confirmation: ["does not match password"]
             } = errors_on(changeset)
    end

    test "validates maximum values for password for security", %{account: account} do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        Iam.update_account_password(account, valid_account_password(), %{password: too_long})

      assert "should be at most 72 character(s)" in errors_on(changeset).password
    end

    test "validates current password", %{account: account} do
      {:error, changeset} =
        Iam.update_account_password(account, "invalid", %{password: valid_account_password()})

      assert %{current_password: ["is not valid"]} = errors_on(changeset)
    end

    test "updates the password", %{account: account} do
      {:ok, account} =
        Iam.update_account_password(account, valid_account_password(), %{
          password: "new valid password"
        })

      assert is_nil(account.password)
      assert Iam.get_account_by_email_and_password(account.email, "new valid password")
    end

    test "deletes all tokens for the given account", %{account: account} do
      _ = Iam.generate_account_session_token(account)

      {:ok, _} =
        Iam.update_account_password(account, valid_account_password(), %{
          password: "new valid password"
        })

      refute Repo.get_by(AccountToken, account_id: account.id)
    end
  end

  describe "generate_account_session_token/1" do
    setup do
      %{account: account_fixture()}
    end

    test "generates a token", %{account: account} do
      token = Iam.generate_account_session_token(account)
      assert account_token = Repo.get_by(AccountToken, token: token)
      assert account_token.context == "session"

      # Creating the same token for another account should fail
      assert_raise Ecto.ConstraintError, fn ->
        Repo.insert!(%AccountToken{
          token: account_token.token,
          account_id: account_fixture().id,
          context: "session"
        })
      end
    end
  end

  describe "get_account_by_session_token/1" do
    setup do
      account = account_fixture()
      token = Iam.generate_account_session_token(account)
      %{account: account, token: token}
    end

    test "returns account by token", %{account: account, token: token} do
      assert session_account = Iam.get_account_by_session_token(token)
      assert session_account.id == account.id
    end

    test "does not return account for invalid token" do
      refute Iam.get_account_by_session_token("oops")
    end

    test "does not return account for expired token", %{token: token} do
      {1, nil} = Repo.update_all(AccountToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])
      refute Iam.get_account_by_session_token(token)
    end
  end

  describe "delete_session_token/1" do
    test "deletes the token" do
      account = account_fixture()
      token = Iam.generate_account_session_token(account)
      assert Iam.delete_session_token(token) == :ok
      refute Iam.get_account_by_session_token(token)
    end
  end

  describe "deliver_account_confirmation_instructions/2" do
    setup do
      %{account: account_fixture()}
    end

    test "sends token through notification", %{account: account} do
      token =
        extract_account_token(fn url ->
          Iam.deliver_account_confirmation_instructions(account, url)
        end)

      {:ok, token} = Base.url_decode64(token, padding: false)
      assert account_token = Repo.get_by(AccountToken, token: :crypto.hash(:sha256, token))
      assert account_token.account_id == account.id
      assert account_token.sent_to == account.email
      assert account_token.context == "confirm"
    end
  end

  describe "confirm_account/1" do
    setup do
      account = account_fixture()

      token =
        extract_account_token(fn url ->
          Iam.deliver_account_confirmation_instructions(account, url)
        end)

      %{account: account, token: token}
    end

    test "confirms the email with a valid token", %{account: account, token: token} do
      assert {:ok, confirmed_account} = Iam.confirm_account(token)
      assert confirmed_account.confirmed_at
      assert confirmed_account.confirmed_at != account.confirmed_at
      assert Repo.get!(Account, account.id).confirmed_at
      refute Repo.get_by(AccountToken, account_id: account.id)
    end

    test "does not confirm with invalid token", %{account: account} do
      assert Iam.confirm_account("oops") == :error
      refute Repo.get!(Account, account.id).confirmed_at
      assert Repo.get_by(AccountToken, account_id: account.id)
    end

    test "does not confirm email if token expired", %{account: account, token: token} do
      {1, nil} = Repo.update_all(AccountToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])
      assert Iam.confirm_account(token) == :error
      refute Repo.get!(Account, account.id).confirmed_at
      assert Repo.get_by(AccountToken, account_id: account.id)
    end
  end

  describe "deliver_account_reset_password_instructions/2" do
    setup do
      %{account: account_fixture()}
    end

    test "sends token through notification", %{account: account} do
      token =
        extract_account_token(fn url ->
          Iam.deliver_account_reset_password_instructions(account, url)
        end)

      {:ok, token} = Base.url_decode64(token, padding: false)
      assert account_token = Repo.get_by(AccountToken, token: :crypto.hash(:sha256, token))
      assert account_token.account_id == account.id
      assert account_token.sent_to == account.email
      assert account_token.context == "reset_password"
    end
  end

  describe "get_account_by_reset_password_token/1" do
    setup do
      account = account_fixture()

      token =
        extract_account_token(fn url ->
          Iam.deliver_account_reset_password_instructions(account, url)
        end)

      %{account: account, token: token}
    end

    test "returns the account with valid token", %{account: %{id: id}, token: token} do
      assert %Account{id: ^id} = Iam.get_account_by_reset_password_token(token)
      assert Repo.get_by(AccountToken, account_id: id)
    end

    test "does not return the account with invalid token", %{account: account} do
      refute Iam.get_account_by_reset_password_token("oops")
      assert Repo.get_by(AccountToken, account_id: account.id)
    end

    test "does not return the account if token expired", %{account: account, token: token} do
      {1, nil} = Repo.update_all(AccountToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])
      refute Iam.get_account_by_reset_password_token(token)
      assert Repo.get_by(AccountToken, account_id: account.id)
    end
  end

  describe "reset_account_password/2" do
    setup do
      %{account: account_fixture()}
    end

    test "validates password", %{account: account} do
      {:error, changeset} =
        Iam.reset_account_password(account, %{
          password: "not valid",
          password_confirmation: "another"
        })

      assert %{
               password: ["should be at least 12 character(s)"],
               password_confirmation: ["does not match password"]
             } = errors_on(changeset)
    end

    test "validates maximum values for password for security", %{account: account} do
      too_long = String.duplicate("db", 100)
      {:error, changeset} = Iam.reset_account_password(account, %{password: too_long})
      assert "should be at most 72 character(s)" in errors_on(changeset).password
    end

    test "updates the password", %{account: account} do
      {:ok, updated_account} = Iam.reset_account_password(account, %{password: "new valid password"})
      assert is_nil(updated_account.password)
      assert Iam.get_account_by_email_and_password(account.email, "new valid password")
    end

    test "deletes all tokens for the given account", %{account: account} do
      _ = Iam.generate_account_session_token(account)
      {:ok, _} = Iam.reset_account_password(account, %{password: "new valid password"})
      refute Repo.get_by(AccountToken, account_id: account.id)
    end
  end

  describe "inspect/2" do
    test "does not include password" do
      refute inspect(%Account{password: "123456"}) =~ "password: \"123456\""
    end
  end

  describe "users" do
    alias Yic.Iam.Users

    import Yic.IamFixtures

    @invalid_attrs %{email: nil, firstname: nil, lastname: nil}

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Iam.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Iam.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      valid_attrs = %{email: "some email", firstname: "some firstname", lastname: "some lastname"}

      assert {:ok, %Users{} = users} = Iam.create_users(valid_attrs)
      assert users.email == "some email"
      assert users.firstname == "some firstname"
      assert users.lastname == "some lastname"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      update_attrs = %{email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname"}

      assert {:ok, %Users{} = users} = Iam.update_users(users, update_attrs)
      assert users.email == "some updated email"
      assert users.firstname == "some updated firstname"
      assert users.lastname == "some updated lastname"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_users(users, @invalid_attrs)
      assert users == Iam.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Iam.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Iam.change_users(users)
    end
  end

  describe "roles" do
    alias Yic.Iam.Roles

    import Yic.IamFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_roles/0 returns all roles" do
      roles = roles_fixture()
      assert Iam.list_roles() == [roles]
    end

    test "get_roles!/1 returns the roles with given id" do
      roles = roles_fixture()
      assert Iam.get_roles!(roles.id) == roles
    end

    test "create_roles/1 with valid data creates a roles" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Roles{} = roles} = Iam.create_roles(valid_attrs)
      assert roles.description == "some description"
      assert roles.name == "some name"
    end

    test "create_roles/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_roles(@invalid_attrs)
    end

    test "update_roles/2 with valid data updates the roles" do
      roles = roles_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Roles{} = roles} = Iam.update_roles(roles, update_attrs)
      assert roles.description == "some updated description"
      assert roles.name == "some updated name"
    end

    test "update_roles/2 with invalid data returns error changeset" do
      roles = roles_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_roles(roles, @invalid_attrs)
      assert roles == Iam.get_roles!(roles.id)
    end

    test "delete_roles/1 deletes the roles" do
      roles = roles_fixture()
      assert {:ok, %Roles{}} = Iam.delete_roles(roles)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_roles!(roles.id) end
    end

    test "change_roles/1 returns a roles changeset" do
      roles = roles_fixture()
      assert %Ecto.Changeset{} = Iam.change_roles(roles)
    end
  end

  describe "groups" do
    alias Yic.Iam.Groups

    import Yic.IamFixtures

    @invalid_attrs %{comment: nil, name: nil}

    test "list_groups/0 returns all groups" do
      groups = groups_fixture()
      assert Iam.list_groups() == [groups]
    end

    test "get_groups!/1 returns the groups with given id" do
      groups = groups_fixture()
      assert Iam.get_groups!(groups.id) == groups
    end

    test "create_groups/1 with valid data creates a groups" do
      valid_attrs = %{comment: "some comment", name: "some name"}

      assert {:ok, %Groups{} = groups} = Iam.create_groups(valid_attrs)
      assert groups.comment == "some comment"
      assert groups.name == "some name"
    end

    test "create_groups/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_groups(@invalid_attrs)
    end

    test "update_groups/2 with valid data updates the groups" do
      groups = groups_fixture()
      update_attrs = %{comment: "some updated comment", name: "some updated name"}

      assert {:ok, %Groups{} = groups} = Iam.update_groups(groups, update_attrs)
      assert groups.comment == "some updated comment"
      assert groups.name == "some updated name"
    end

    test "update_groups/2 with invalid data returns error changeset" do
      groups = groups_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_groups(groups, @invalid_attrs)
      assert groups == Iam.get_groups!(groups.id)
    end

    test "delete_groups/1 deletes the groups" do
      groups = groups_fixture()
      assert {:ok, %Groups{}} = Iam.delete_groups(groups)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_groups!(groups.id) end
    end

    test "change_groups/1 returns a groups changeset" do
      groups = groups_fixture()
      assert %Ecto.Changeset{} = Iam.change_groups(groups)
    end
  end

  describe "systems" do
    alias Yic.Iam.System

    import Yic.IamFixtures

    @invalid_attrs %{comment: nil, host: nil, name: nil}

    test "list_systems/0 returns all systems" do
      system = system_fixture()
      assert Iam.list_systems() == [system]
    end

    test "get_system!/1 returns the system with given id" do
      system = system_fixture()
      assert Iam.get_system!(system.id) == system
    end

    test "create_system/1 with valid data creates a system" do
      valid_attrs = %{comment: "some comment", host: "some host", name: "some name"}

      assert {:ok, %System{} = system} = Iam.create_system(valid_attrs)
      assert system.comment == "some comment"
      assert system.host == "some host"
      assert system.name == "some name"
    end

    test "create_system/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_system(@invalid_attrs)
    end

    test "update_system/2 with valid data updates the system" do
      system = system_fixture()
      update_attrs = %{comment: "some updated comment", host: "some updated host", name: "some updated name"}

      assert {:ok, %System{} = system} = Iam.update_system(system, update_attrs)
      assert system.comment == "some updated comment"
      assert system.host == "some updated host"
      assert system.name == "some updated name"
    end

    test "update_system/2 with invalid data returns error changeset" do
      system = system_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_system(system, @invalid_attrs)
      assert system == Iam.get_system!(system.id)
    end

    test "delete_system/1 deletes the system" do
      system = system_fixture()
      assert {:ok, %System{}} = Iam.delete_system(system)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_system!(system.id) end
    end

    test "change_system/1 returns a system changeset" do
      system = system_fixture()
      assert %Ecto.Changeset{} = Iam.change_system(system)
    end
  end

  describe "actions" do
    alias Yic.Iam.Action

    import Yic.IamFixtures

    @invalid_attrs %{comment: nil, name: nil, url: nil}

    test "list_actions/0 returns all actions" do
      action = action_fixture()
      assert Iam.list_actions() == [action]
    end

    test "get_action!/1 returns the action with given id" do
      action = action_fixture()
      assert Iam.get_action!(action.id) == action
    end

    test "create_action/1 with valid data creates a action" do
      valid_attrs = %{comment: "some comment", name: "some name", url: "some url"}

      assert {:ok, %Action{} = action} = Iam.create_action(valid_attrs)
      assert action.comment == "some comment"
      assert action.name == "some name"
      assert action.url == "some url"
    end

    test "create_action/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_action(@invalid_attrs)
    end

    test "update_action/2 with valid data updates the action" do
      action = action_fixture()
      update_attrs = %{comment: "some updated comment", name: "some updated name", url: "some updated url"}

      assert {:ok, %Action{} = action} = Iam.update_action(action, update_attrs)
      assert action.comment == "some updated comment"
      assert action.name == "some updated name"
      assert action.url == "some updated url"
    end

    test "update_action/2 with invalid data returns error changeset" do
      action = action_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_action(action, @invalid_attrs)
      assert action == Iam.get_action!(action.id)
    end

    test "delete_action/1 deletes the action" do
      action = action_fixture()
      assert {:ok, %Action{}} = Iam.delete_action(action)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_action!(action.id) end
    end

    test "change_action/1 returns a action changeset" do
      action = action_fixture()
      assert %Ecto.Changeset{} = Iam.change_action(action)
    end
  end

  describe "allows" do
    alias Yic.Iam.Allow

    import Yic.IamFixtures

    @invalid_attrs %{}

    test "list_allows/0 returns all allows" do
      allow = allow_fixture()
      assert Iam.list_allows() == [allow]
    end

    test "get_allow!/1 returns the allow with given id" do
      allow = allow_fixture()
      assert Iam.get_allow!(allow.id) == allow
    end

    test "create_allow/1 with valid data creates a allow" do
      valid_attrs = %{}

      assert {:ok, %Allow{} = allow} = Iam.create_allow(valid_attrs)
    end

    test "create_allow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_allow(@invalid_attrs)
    end

    test "update_allow/2 with valid data updates the allow" do
      allow = allow_fixture()
      update_attrs = %{}

      assert {:ok, %Allow{} = allow} = Iam.update_allow(allow, update_attrs)
    end

    test "update_allow/2 with invalid data returns error changeset" do
      allow = allow_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_allow(allow, @invalid_attrs)
      assert allow == Iam.get_allow!(allow.id)
    end

    test "delete_allow/1 deletes the allow" do
      allow = allow_fixture()
      assert {:ok, %Allow{}} = Iam.delete_allow(allow)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_allow!(allow.id) end
    end

    test "change_allow/1 returns a allow changeset" do
      allow = allow_fixture()
      assert %Ecto.Changeset{} = Iam.change_allow(allow)
    end
  end

  describe "denies" do
    alias Yic.Iam.Denie

    import Yic.IamFixtures

    @invalid_attrs %{}

    test "list_denies/0 returns all denies" do
      denie = denie_fixture()
      assert Iam.list_denies() == [denie]
    end

    test "get_denie!/1 returns the denie with given id" do
      denie = denie_fixture()
      assert Iam.get_denie!(denie.id) == denie
    end

    test "create_denie/1 with valid data creates a denie" do
      valid_attrs = %{}

      assert {:ok, %Denie{} = denie} = Iam.create_denie(valid_attrs)
    end

    test "create_denie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_denie(@invalid_attrs)
    end

    test "update_denie/2 with valid data updates the denie" do
      denie = denie_fixture()
      update_attrs = %{}

      assert {:ok, %Denie{} = denie} = Iam.update_denie(denie, update_attrs)
    end

    test "update_denie/2 with invalid data returns error changeset" do
      denie = denie_fixture()
      assert {:error, %Ecto.Changeset{}} = Iam.update_denie(denie, @invalid_attrs)
      assert denie == Iam.get_denie!(denie.id)
    end

    test "delete_denie/1 deletes the denie" do
      denie = denie_fixture()
      assert {:ok, %Denie{}} = Iam.delete_denie(denie)
      assert_raise Ecto.NoResultsError, fn -> Iam.get_denie!(denie.id) end
    end

    test "change_denie/1 returns a denie changeset" do
      denie = denie_fixture()
      assert %Ecto.Changeset{} = Iam.change_denie(denie)
    end
  end
end
