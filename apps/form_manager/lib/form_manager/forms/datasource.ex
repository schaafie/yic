defmodule FormManager.Forms.Datasource do
  use Ecto.Schema
  import Ecto.Changeset


  schema "datasources" do
    field :name, :string
    field :version, :string
    field :comment, :string
    field :definition, :map
    field :actions, {:array, :map}

    timestamps()
  end

  @doc false
  def changeset(datasource, attrs) do
    datasource
    |> cast(attrs, [:name, :comment, :version, :definition, :actions])
    |> validate_required([:name, :version, :definition, :actions])
  end
end
