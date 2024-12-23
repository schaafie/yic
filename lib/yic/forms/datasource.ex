defmodule Yic.Forms.Datasource do
  use Ecto.Schema
  import Ecto.Changeset
  alias Yic.Json

  schema "datasources" do
    field :actions, {:array, :string}
    field :comment, :string
    field :definition, :map #Json
    field :name, :string
    field :version, :map  #Json

    timestamps()
  end

  @doc false
  def changeset(datasource, attrs) do
    datasource
    |> cast(attrs, [:name, :comment, :version, :definition, :actions])
    |> validate_required([:name, :comment, :version, :definition, :actions])
  end
end
