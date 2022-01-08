defmodule Yic.IamTest do
  use Yic.DataCase

  alias Yic.Iam

  describe "users" do
    alias Yic.Iam.Users

    import Yic.IamFixtures

    @invalid_attrs %{email: nil, firstname: nil, lastname: nil, login: nil, password: nil}

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Iam.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Iam.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      valid_attrs = %{email: "some email", firstname: "some firstname", lastname: "some lastname", login: "some login", password: "some password"}

      assert {:ok, %Users{} = users} = Iam.create_users(valid_attrs)
      assert users.email == "some email"
      assert users.firstname == "some firstname"
      assert users.lastname == "some lastname"
      assert users.login == "some login"
      assert users.password == "some password"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Iam.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      update_attrs = %{email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", login: "some updated login", password: "some updated password"}

      assert {:ok, %Users{} = users} = Iam.update_users(users, update_attrs)
      assert users.email == "some updated email"
      assert users.firstname == "some updated firstname"
      assert users.lastname == "some updated lastname"
      assert users.login == "some updated login"
      assert users.password == "some updated password"
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
