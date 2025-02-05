defmodule Yic.Flows.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :can_do, :map
    field :flow_id, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:can_do])
    |> validate_required([:can_do])
  end
end
