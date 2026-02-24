defmodule Yic.Schemas do
  @moduledoc """
  The Schemas context.
  """

  import Ecto.Query, warn: false
  alias Yic.Repo

  alias Yic.Schemas.Schema

  @doc """
  Returns the list of schemas.

  ## Examples

      iex> list_schemas()
      [%Schema{}, ...]

  """
  def list_schemas do
    Repo.all(Schema)
  end

  @doc """
  Gets a single schema.

  Raises `Ecto.NoResultsError` if the Schema does not exist.

  ## Examples

      iex> get_schema!(123)
      %Schema{}

      iex> get_schema!(456)
      ** (Ecto.NoResultsError)

  """
  def get_schema!(id), do: Repo.get!(Schema, id)

  @doc """
  Creates a schema.

  ## Examples

      iex> create_schema(%{field: value})
      {:ok, %Schema{}}

      iex> create_schema(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_schema(attrs \\ %{}) do
    %Schema{}
    |> Schema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a schema.

  ## Examples

      iex> update_schema(schema, %{field: new_value})
      {:ok, %Schema{}}

      iex> update_schema(schema, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_schema(%Schema{} = schema, attrs) do
    schema
    |> Schema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a schema.

  ## Examples

      iex> delete_schema(schema)
      {:ok, %Schema{}}

      iex> delete_schema(schema)
      {:error, %Ecto.Changeset{}}

  """
  def delete_schema(%Schema{} = schema) do
    Repo.delete(schema)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking schema changes.

  ## Examples

      iex> change_schema(schema)
      %Ecto.Changeset{data: %Schema{}}

  """
  def change_schema(%Schema{} = schema, attrs \\ %{}) do
    Schema.changeset(schema, attrs)
  end
end
