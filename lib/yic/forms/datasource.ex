defmodule Yic.Forms.Datasource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "datasources" do
    field :actions, {:array, :string}
    field :comment, :string
    field :definition, :string
    field :name, :string
    field :version, :string

    timestamps()
  end

  @doc false
  def changeset(datasource, attrs) do
    datasource
    |> cast(attrs, [:name, :comment, :version, :definition, :actions])
    |> validate_required([:name, :comment, :version, :definition, :actions])
  end
end
