defmodule PublicationManager.Publications do
  @moduledoc """
  The Publications context.
  """
  use HTTPoison.Base

  import Ecto.Query, warn: false
  alias PublicationManager.Repo

  alias PublicationManager.Publications.Publication

  @doc """
  Returns the list of publications.

  ## Examples

      iex> list_publications()
      [%Publication{}, ...]

  """
  def list_publications do
    Repo.all(Publication)
  end

  @doc """
  Gets a single publication.

  Raises `Ecto.NoResultsError` if the Publication does not exist.

  ## Examples

      iex> get_publication!(123)
      %Publication{}

      iex> get_publication!(456)
      ** (Ecto.NoResultsError)

  """
  def get_publication!(id), do: Repo.get!(Publication, id)

  def get_publication_by_name!(name, id) do 
    base_page = Repo.get_by!(Publication, path: name)
    def = base_page.definition

    definition = def
    |> put_in( ["main", "data"], get_data( def["main"]["datapath"], id ) )
    |> put_in( ["main", "datadef"], get_data_def( def["main"]["datadefpath"] ) )
    |> put_in( ["main", "pageelement"], get_page_element( def["main"]["pageelementpath"] ) )
    struct(base_page, definition: definition)
  end
  
  def get_publication_by_name!(name) do
    base_page = Repo.get_by!(Publication, path: name)    

    def = base_page.definition

    # tasks = [ Task.async( fn -> {"dp", get_data(def["main"]["datapath"])}), 
    #           Task.async( fn -> {"ddp", get_data(def["main"]["datadefpath"])}), 
    #           Task.async( fn -> {"pep", get_data(def["main"]["pageelementpath"])})]

    # for item -> Task.yield_many(tasks, 5000) do
    #   switch(item) do
    #     case {:ok, {"dp"} -> 
    #       put_in( def, ["main", "data"], get_data( def["main"]["datapath"] ) ) }
    #   end

    definition = def
    |> put_in( ["main", "data"], get_data( def["main"]["datapath"] ) )
    |> put_in( ["main", "datadef"], get_data_def( def["main"]["datadefpath"] ) )
    |> put_in( ["main", "pageelement"], get_page_element( def["main"]["pageelementpath"] ) )

    struct(base_page, definition: definition)
  end

  def get_data path do
    datapath = "http://localhost:4000" <> path
    call_api datapath
  end

  def get_data path, id do
    datapath = "http://localhost:4000" <> String.replace_trailing(path, "@id", id)
    call_api datapath
  end

  def get_data_def path do
    datapath = "http://localhost:4000" <> path
    call_api datapath
  end

  def get_page_element path do
    datapath = "http://localhost:4000" <> path
    call_api datapath
  end

  def call_api datapath do
    IO.puts "CALLING " <> datapath
    case HTTPoison.get(datapath) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, data} = Poison.decode(body)
        data["data"]
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Nothing found at " <> datapath
        %{}
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
        %{}
    end       
  end

  @doc """
  Creates a publication.

  ## Examples

      iex> create_publication(%{field: value})
      {:ok, %Publication{}}

      iex> create_publication(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_publication(attrs \\ %{}) do
    %Publication{}
    |> Publication.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a publication.

  ## Examples

      iex> update_publication(publication, %{field: new_value})
      {:ok, %Publication{}}

      iex> update_publication(publication, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_publication(%Publication{} = publication, attrs) do
    publication
    |> Publication.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Publication.

  ## Examples

      iex> delete_publication(publication)
      {:ok, %Publication{}}

      iex> delete_publication(publication)
      {:error, %Ecto.Changeset{}}

  """
  def delete_publication(%Publication{} = publication) do
    Repo.delete(publication)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking publication changes.

  ## Examples

      iex> change_publication(publication)
      %Ecto.Changeset{source: %Publication{}}

  """
  def change_publication(%Publication{} = publication) do
    Publication.changeset(publication, %{})
  end
end
