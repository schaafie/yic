defmodule Yic.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Yic.Content` context.
  """

  @doc """
  Generate a template.
  """
  def template_fixture(attrs \\ %{}) do
    {:ok, template} =
      attrs
      |> Enum.into(%{
        definition: %{},
        description: "some description",
        name: "some name",
        version: %{}
      })
      |> Yic.Content.create_template()

    template
  end

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        content: %{},
        description: "some description",
        name: "some name",
        version: %{}
      })
      |> Yic.Content.create_item()

    item
  end
end
