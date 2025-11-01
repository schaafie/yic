defmodule Yic.Flows.Token do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :can_do, :map
    field :current_task, :string
    field :flow_id, :id
    field :claimed_by, :id

    timestamps()
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:current_task, :can_do])
    |> validate_required([:current_task, :can_do])
  end
end
