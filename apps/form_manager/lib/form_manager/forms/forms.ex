defmodule FormManager.Forms do
  @moduledoc """
  The Forms context.
  """

  import Ecto.Query, warn: false
  alias FormManager.Repo

  alias FormManager.Forms.Form

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
  Deletes a Form.

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
      %Ecto.Changeset{source: %Form{}}

  """
  def change_form(%Form{} = form) do
    Form.changeset(form, %{})
  end

  alias FormManager.Forms.Datasource

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
  Deletes a Datasource.

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
      %Ecto.Changeset{source: %Datasource{}}

  """
  def change_datasource(%Datasource{} = datasource) do
    Datasource.changeset(datasource, %{})
  end
end
