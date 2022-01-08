defmodule Yic.IamFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Yic.Iam` context.
  """

  @doc """
  Generate a users.
  """
  def users_fixture(attrs \\ %{}) do
    {:ok, users} =
      attrs
      |> Enum.into(%{
        email: "some email",
        firstname: "some firstname",
        lastname: "some lastname",
        login: "some login",
        password: "some password"
      })
      |> Yic.Iam.create_users()

    users
  end

  @doc """
  Generate a roles.
  """
  def roles_fixture(attrs \\ %{}) do
    {:ok, roles} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Yic.Iam.create_roles()

    roles
  end

  @doc """
  Generate a groups.
  """
  def groups_fixture(attrs \\ %{}) do
    {:ok, groups} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        name: "some name"
      })
      |> Yic.Iam.create_groups()

    groups
  end

  @doc """
  Generate a system.
  """
  def system_fixture(attrs \\ %{}) do
    {:ok, system} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        host: "some host",
        name: "some name"
      })
      |> Yic.Iam.create_system()

    system
  end

  @doc """
  Generate a action.
  """
  def action_fixture(attrs \\ %{}) do
    {:ok, action} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        name: "some name",
        url: "some url"
      })
      |> Yic.Iam.create_action()

    action
  end

  @doc """
  Generate a allow.
  """
  def allow_fixture(attrs \\ %{}) do
    {:ok, allow} =
      attrs
      |> Enum.into(%{

      })
      |> Yic.Iam.create_allow()

    allow
  end

  @doc """
  Generate a denie.
  """
  def denie_fixture(attrs \\ %{}) do
    {:ok, denie} =
      attrs
      |> Enum.into(%{

      })
      |> Yic.Iam.create_denie()

    denie
  end
end
