defmodule Yic.Apis do
  @moduledoc """
  The Apis context.
  """

  import Ecto.Query, warn: false
  alias Yic.Repo

  alias Yic.Apis.Api

  @doc """
  Returns the list of apis.

  ## Examples

      iex> list_apis()
      [%Api{}, ...]

  """
  def list_apis, do: Repo.all(Api)

  @doc """
  Gets a single api.

  Raises `Ecto.NoResultsError` if the Api does not exist.

  ## Examples

      iex> get_api!(123)
      %Api{}

      iex> get_api!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api!(id), do: Repo.get!(Api, id)

  @doc """
  Creates a api.

  ## Examples

      iex> create_api(%{field: value})
      {:ok, %Api{}}

      iex> create_api(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api(attrs \\ %{}) do
    %Api{}
    |> Api.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a api.

  ## Examples

      iex> update_api(api, %{field: new_value})
      {:ok, %Api{}}

      iex> update_api(api, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api(%Api{} = api, attrs) do
    api
    |> Api.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a api.

  ## Examples

      iex> delete_api(api)
      {:ok, %Api{}}

      iex> delete_api(api)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api(%Api{} = api) do
    Repo.delete(api)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking api changes.

  ## Examples

      iex> change_api(api)
      %Ecto.Changeset{data: %Api{}}

  """
  def change_api(%Api{} = api, attrs \\ %{}) do
    Api.changeset(api, attrs)
  end

  @doc """
  Matches an api against a array representing the path.

  """
  def match_call( path ) do
    try do
      str_path = Enum.join(path, "/")
      result = Repo.get_by!( Api, request: str_path )
      {:ok, result.definition }
    rescue
      Ecto.NoResultsError ->
        :nok  
    end
  end

  def match_call_id( path ) do
    try do
        value = List.last(path)
        {_end, str_path} = List.pop_at(path,-1)
        atr_path_with_key = Enum.join(str_path ++ [":id"], "/")
        result = Repo.get_by!( Api, request: atr_path_with_key )
        {:ok, result.definition, value}
    rescue
      Ecto.NoResultsError ->
        :nok  
    end    
  end

  def refresh_token, do: Yic.Apis.TokenRegistry.addsystem

end
