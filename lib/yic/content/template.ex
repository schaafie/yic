defmodule Yic.Content.Template do
  use Ecto.Schema
  import Ecto.Changeset
  import Yic.SchemaValidator
  alias Yic.Json

  schema "templates" do
    field :definition, Json
    field :description, :string
    field :name, :string
    field :version, Json
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(template, attrs) do
    template
    |> cast(attrs, [:name, :description, :version, :definition, :owner ])
    |> validate_changes_against_schema( "contenttemplate" )
  end

  # def datadef() do
  #   %{ root: "template", datatypes: [
  #     %{ name: "template", basetype: "map", type: "form", fields: [
  #       %{ field: "id", required: false}, 
  #       %{ field: "description", required: true}, 
  #       %{ field: "definition", required: true}, 
  #       %{ field: "name", required: true}, 
  #       %{ field: "version", required: true}, 
  #       %{ field: "owner", required: false}
  #     ]},
  #     %{ name: "description", basetype: "string", validations: []},
  #     %{ name: "definition", basetype: "string", type: "map", fields: [
  #       %{ field: "type", required: true}, 
  #       %{ field: "elements", required: true}, 
  #       %{ field: "title", required: true}
  #     ]},
  #     %{ name: "id", basetype: "number", validations: []},
  #     %{ name: "type", basetype: "string", validations: []},
  #     %{ name: "elements", basetype: "array", validations: []},
  #     %{ name: "title", basetype: "string", validations: []},
  #     %{ name: "name", basetype: "string", validations: []},
  #     %{ name: "version", basetype: "string", type: "map", fields: [
  #       %{ field: "minor", required: false}, 
  #       %{ field: "medior", required: false}, 
  #       %{ field: "major", required: false}, 
  #       %{ field: "author", required: false}, 
  #       %{ field: "comment", required: false}
  #     ]},
  #     %{ name: "minor", basetype: "number", validations: []},
  #     %{ name: "medior", basetype: "number", validations: []},
  #     %{ name: "major", basetype: "number", validations: []},
  #     %{ name: "author", basetype: "id", validations: []},
  #     %{ name: "comment", basetype: "string", validations: []},
  #     %{ name: "owner", basetype: "id", validations: []}
  #   ]}
  # end  
end
