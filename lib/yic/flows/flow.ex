defmodule Yic.Flows.Flow do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flows" do
    field :can_start, :map
    field :definition, :map
    field :description, :string
    field :name, :string
    field :version, :map

    timestamps()
  end

  @doc false
  def changeset(flow, attrs) do
    flow
    |> cast(attrs, [:name, :description, :version, :definition, :can_start])
    |> validate_required([:name, :description, :version, :definition, :can_start])
  end
end
