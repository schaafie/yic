defmodule Yic.Forms.Datadef do
  use Ecto.Schema
  import Ecto.Changeset
  import Yic.Validate
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
#    |> validate_changes_against_datadef( "datadef" )
#    |> validate_required([:name, :comment, :version, :definition])
    |> validate_changes_against_datadef( datadef() )
end

  def datadef( ) do
    %{ root: "datadef", datatypes: [
      %{ name: "datadef", basetype: "map", validations: [ 
        %{ type: "fields", strict: true, fields: [
          %{ field: "id", required: false },
          %{ field: "name", required: true },
          %{ field: "comment", required: true },
          %{ field: "definition", required: true},
          %{ field: "version", required: true }
        ]}
      ]},
      %{ name: "id", basetype: "number", validations: [] },
      %{ name: "name", basetype: "string", validations: [] },
      %{ name: "comment", basetype: "string", validations: [] },
      %{ name: "definition", basetype: "map", validations: [ %{ type: "fields", strict: false, fields: []} ]},
      %{ name: "version", basetype: "string", validations: [ %{ type: "format", rule: "^(\\d+\\.)?(\\d+\\.)?(\\*|\\d+)$", error: "Invalid version format." }]}
    ]}
  end

end
