defmodule Yic.Flows.Token do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :token, :map
    field :flow_id, :id
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:token])
    |> validate_required([:token])
  end
end
