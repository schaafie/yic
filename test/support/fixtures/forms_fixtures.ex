defmodule Yic.FormsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Yic.Forms` context.
  """

  @doc """
  Generate a form.
  """
  def form_fixture(attrs \\ %{}) do
    {:ok, form} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        definition: "some definition",
        name: "some name",
        version: "some version"
      })
      |> Yic.Forms.create_form()

    form
  end

  @doc """
  Generate a datasource.
  """
  def datasource_fixture(attrs \\ %{}) do
    {:ok, datasource} =
      attrs
      |> Enum.into(%{
        actions: [],
        comment: "some comment",
        definition: "some definition",
        name: "some name",
        version: "some version"
      })
      |> Yic.Forms.create_datasource()

    datasource
  end

  @doc """
  Generate a datadef.
  """
  def datadef_fixture(attrs \\ %{}) do
    {:ok, datadef} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        definition: %{},
        name: "some name",
        version: "some version"
      })
      |> Yic.Forms.create_datadef()

    datadef
  end
end
