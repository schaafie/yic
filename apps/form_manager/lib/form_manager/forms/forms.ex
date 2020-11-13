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
end
