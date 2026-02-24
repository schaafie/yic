defmodule Yic.Schemas.Schema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schemas" do
    field :definition, :map
    field :description, :string
    field :name, :string
    field :version, :map

    timestamps()
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:name, :description, :version, :definition])
    |> validate_required([:name, :description, :version, :definition])
  end
end
