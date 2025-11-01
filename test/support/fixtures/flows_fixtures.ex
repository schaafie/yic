defmodule Yic.FlowsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Yic.Flows` context.
  """

  @doc """
  Generate a flow.
  """
  def flow_fixture(attrs \\ %{}) do
    {:ok, flow} =
      attrs
      |> Enum.into(%{
        can_start: %{},
        definition: %{},
        description: "some description",
        name: "some name",
        version: %{}
      })
      |> Yic.Flows.create_flow()

    flow
  end

  @doc """
  Generate a token.
  """
  def token_fixture(attrs \\ %{}) do
    {:ok, token} =
      attrs
      |> Enum.into(%{
        can_do: %{},
        current_task: "some current_task"
      })
      |> Yic.Flows.create_token()

    token
  end
end
