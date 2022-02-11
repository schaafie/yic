defmodule Yic.ApisFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Yic.Apis` context.
  """

  @doc """
  Generate a api.
  """
  def api_fixture(attrs \\ %{}) do
    {:ok, api} =
      attrs
      |> Enum.into(%{
        definition: "some definition",
        description: "some description",
        name: "some name",
        request: "some request",
        version: "some version"
      })
      |> Yic.Apis.create_api()

    api
  end
end
