defmodule Yic.Forms.Datadef do
  use Ecto.Schema
  import Ecto.Changeset
  import Yic.SchemaValidator
  alias Yic.Json

  schema "datadefs" do
    field :comment, :string
    field :definition, Json
    field :name, :string
    field :version, Json

    timestamps()
  end

  @doc false
  def changeset(datadef, attrs) do
    datadef
    |> cast(attrs, [:name, :comment, :version, :definition])
    |> validate_changes_against_schema( "datadef" )
  end
end

  # import Yic.SchemaValidator
  # def datadef() do
  #   %{
  #     "$schema": "https://json-schema.org/draft/2020-12/schema",
  #     title: "data definition schema",
  #     type: "object",
  #     description: "Schema that defines what the data definition should look like",
  #     required: [ "name", "definition", "version" ],
  #     properties: %{
  #       id: %{ type: "integer", description: "" },
  #       name: %{ type: "string", description: "" },
  #       comment: %{ type: "string", description: "" },
  #       definition: %{ 
  #         type: "object", 
  #         description: "Data Definition object", 
  #         properties: %{},
  #         required: [],
  #         additionalProperties: true
  #       },
  #       version: %{
  #         type: "object",
  #         description: "Version object",
  #         required: [ "minor", "medior", "major", "author" ],
  #         properties: %{
  #           minor: %{ type: "integer", description: "", minimum: 0 },
  #           medior: %{ type: "integer", description: "", minimum: 0 },
  #           major: %{ type: "integer", description: "", minimum: 0 },
  #           author: %{ type: "integer", description: "" },
  #           comment: %{ type: "string", description: "" }
  #         }
  #       }
  #     }
  #   }
  # end
  #
  # import Yic.Validate
  # def datadef_org( ) do
  #   %{ root: "datadef", datatypes: [
  #     %{ name: "datadef", basetype: "map", validations: [ 
  #       %{ type: "fields", strict: true, fields: [
  #         %{ field: "id", required: false },
  #         %{ field: "name", required: true },
  #         %{ field: "comment", required: true },
  #         %{ field: "definition", required: true},
  #         %{ field: "version", required: true }
  #       ]}
  #     ]},
  #     %{ name: "id", basetype: "number", validations: [] },
  #     %{ name: "name", basetype: "string", validations: [] },
  #     %{ name: "comment", basetype: "string", validations: [] },
  #     %{ name: "definition", basetype: "map", validations: [ %{ type: "fields", strict: false, fields: []} ]},
  #     %{ name: "version", basetype: "map", validations: [
  #       %{ type: "fields",  strict: false, fields: [
  #         %{ field: "major", required: true },
  #         %{ field: "medior", required: true },
  #         %{ field: "minor", required: true },
  #         %{ field: "author", required: true },
  #         %{ field: "comment", required: true }
  #       ]} 
  #     ]}
  #   ]}
  # end
