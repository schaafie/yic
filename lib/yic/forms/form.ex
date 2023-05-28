defmodule Yic.Forms.Form do
  use Ecto.Schema
  import Ecto.Changeset
  import Yic.Validate
  alias Yic.Json

  schema "forms" do
    field :comment, :string
    field :definition, Json
    field :name, :string
    field :version, :string
    field :author, :id

    timestamps()
  end

  @doc false
  def changeset(form, attrs) do
    form
    |> cast(attrs, [:name, :comment, :version, :definition, :author])
    |> validate_changes_against_datadef( "form" )
  end

  def datadef() do
    %{ root: "form", datatypes: [
      %{ name: "form", basetype: "map", type: "form", fields: [
        %{ field: "id", required: false}, 
        %{ field: "comment", required: true}, 
        %{ field: "definition", required: true}, 
        %{ field: "name", required: true}, 
        %{ field: "version", required: true}, 
        %{ field: "author", required: false}
      ]},
      %{ name: "comment", basetype: "string", validations: []},
      %{ name: "definition", basetype: "string", type: "map", fields: [
        %{ field: "action", required: false}, 
        %{ field: "saveaction", required: false}, 
        %{ field: "createaction", required: false}, 
        %{ field: "type", required: true}, 
        %{ field: "elements", required: true}, 
        %{ field: "title", required: true}
      ]},
      %{ name: "id", basetype: "number", validations: []},
      %{ name: "action", basetype: "string", validations: []},
      %{ name: "saveaction", basetype: "string", validations: []},
      %{ name: "createaction", basetype: "string", validations: []},
      %{ name: "type", basetype: "string", validations: []},
      %{ name: "elements", basetype: "array", validations: []},
      %{ name: "title", basetype: "string", validations: []},
      %{ name: "label", basetype: "string", validations: []},
      %{ name: "name", basetype: "string", validations: []},
      %{ name: "version", basetype: "string", validations: [ %{ type: "format", rule: "^(\\d+\\.)?(\\d+\\.)?(\\*|\\d+)$", error: "Invalid version format." }] },
      %{ name: "author", basetype: "id", validations: []}
    ]}
  end
end
