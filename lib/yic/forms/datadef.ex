defmodule Yic.Forms.Datadef do
  use Ecto.Schema
  import Ecto.Changeset
  alias Yic.Json

  schema "datadefs" do
    field :comment, :string
    field :definition, Json
    field :name, :string
    field :version, :string

    timestamps()
  end

  @doc false
  def changeset(datadef, attrs) do
    datadef
    |> cast(attrs, [:name, :comment, :version, :definition])
    |> validate_required([:name, :comment, :version, :definition])
  end
end
