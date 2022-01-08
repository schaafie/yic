defmodule Yic.Iam do
  @moduledoc """
  The Iam context.
  """

  import Ecto.Query, warn: false
  alias Yic.Repo

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
