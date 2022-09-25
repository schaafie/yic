defmodule Yic.Forms do
  @moduledoc """
  The Forms context.
  """

  import Ecto.Query, warn: false
  alias Yic.Repo

  alias Yic.Forms.Form

  def get_datadef(), do: Form.datadef()

  @doc """
  Returns the list of forms.

  ## Examples

      iex> list_forms()
      [%Form{}, ...]

  """
  def list_forms do
    Repo.all(Form)
  end

  @doc """
  Gets a single form.

  Raises `Ecto.NoResultsError` if the Form does not exist.

  ## Examples

      iex> get_form!(123)
      %Form{}

      iex> get_form!(456)
      ** (Ecto.NoResultsError)

  """
  def get_form!(id), do: Repo.get!(Form, id)
  def get_form_by_name!(name), do: Repo.get_by!(Form, name: name)

  @doc """
  Creates a form.

  ## Examples

      iex> create_form(%{field: value})
      {:ok, %Form{}}

      iex> create_form(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_form(attrs \\ %{}) do
    %Form{}
    |> Form.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a form.

  ## Examples

      iex> update_form(form, %{field: new_value})
      {:ok, %Form{}}

      iex> update_form(form, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_form(%Form{} = form, attrs) do
    form
    |> Form.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a form.

  ## Examples

      iex> delete_form(form)
      {:ok, %Form{}}

      iex> delete_form(form)
      {:error, %Ecto.Changeset{}}

  """
  def delete_form(%Form{} = form) do
    Repo.delete(form)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking form changes.

  ## Examples

      iex> change_form(form)
      %Ecto.Changeset{data: %Form{}}

  """
  def change_form(%Form{} = form, attrs \\ %{}) do
    Form.changeset(form, attrs)
  end

  alias Yic.Forms.Datasource

  @doc """
  Returns the list of datasources.

  ## Examples

      iex> list_datasources()
      [%Datasource{}, ...]

  """
  def list_datasources do
    Repo.all(Datasource)
  end

  @doc """
  Gets a single datasource.

  Raises `Ecto.NoResultsError` if the Datasource does not exist.

  ## Examples

      iex> get_datasource!(123)
      %Datasource{}

      iex> get_datasource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_datasource!(id), do: Repo.get!(Datasource, id)

  @doc """
  Creates a datasource.

  ## Examples

      iex> create_datasource(%{field: value})
      {:ok, %Datasource{}}

      iex> create_datasource(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_datasource(attrs \\ %{}) do
    %Datasource{}
    |> Datasource.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a datasource.

  ## Examples

      iex> update_datasource(datasource, %{field: new_value})
      {:ok, %Datasource{}}

      iex> update_datasource(datasource, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_datasource(%Datasource{} = datasource, attrs) do
    datasource
    |> Datasource.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a datasource.

  ## Examples

      iex> delete_datasource(datasource)
      {:ok, %Datasource{}}

      iex> delete_datasource(datasource)
      {:error, %Ecto.Changeset{}}

  """
  def delete_datasource(%Datasource{} = datasource) do
    Repo.delete(datasource)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking datasource changes.

  ## Examples

      iex> change_datasource(datasource)
      %Ecto.Changeset{data: %Datasource{}}

  """
  def change_datasource(%Datasource{} = datasource, attrs \\ %{}) do
    Datasource.changeset(datasource, attrs)
  end

  alias Yic.Forms.Datadef

  @doc """
  Returns the list of datadefs.

  ## Examples

      iex> list_datadefs()
      [%Datadef{}, ...]

  """
  def list_datadefs do
    Repo.all(Datadef)
  end

  @doc """
  Gets a single datadef.

  Raises `Ecto.NoResultsError` if the Datadef does not exist.

  ## Examples

      iex> get_datadef!(123)
      %Datadef{}

      iex> get_datadef!(456)
      ** (Ecto.NoResultsError)

  """
  def get_datadef!(id), do: Repo.get!(Datadef, id)
  def get_datadef_by_name!(name), do: Repo.get_by!(Datadef, name: name)

  @doc """
  Creates a datadef.

  ## Examples

      iex> create_datadef(%{field: value})
      {:ok, %Datadef{}}

      iex> create_datadef(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_datadef(attrs \\ %{}) do
    %Datadef{}
    |> Datadef.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a datadef.

  ## Examples

      iex> update_datadef(datadef, %{field: new_value})
      {:ok, %Datadef{}}

      iex> update_datadef(datadef, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_datadef(%Datadef{} = datadef, attrs) do
    datadef
    |> Datadef.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a datadef.

  ## Examples

      iex> delete_datadef(datadef)
      {:ok, %Datadef{}}

      iex> delete_datadef(datadef)
      {:error, %Ecto.Changeset{}}

  """
  def delete_datadef(%Datadef{} = datadef) do
    Repo.delete(datadef)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking datadef changes.

  ## Examples

      iex> change_datadef(datadef)
      %Ecto.Changeset{data: %Datadef{}}

  """
  def change_datadef(%Datadef{} = datadef, attrs \\ %{}) do
    Datadef.changeset(datadef, attrs)
  end
end
