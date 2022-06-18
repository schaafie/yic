defmodule Yic.Forms.Form do
  use Ecto.Schema
  import Ecto.Changeset
  import Yic.Validate

  schema "forms" do
    field :comment, :string
    field :definition, :string
    field :name, :string
    field :version, :string
    field :author, :id

    timestamps()
  end

  @doc false
  def changeset(form, attrs) do
    form
    |> cast(attrs, [:name, :comment, :version, :definition, :author])
    |> validate_required([:name, :comment, :version, :definition])
    |> validate_changes_against_datadef( datadef() )
  end

  def datadef() do
    %{ root: "form", datatypes: [
      %{ name: "form", basetype: "map", type: "form", fields: [
        %{ field: "comment", required: true}, 
        %{ field: "definition", required: true}, 
        %{ field: "name", required: true}, 
        %{ field: "version", required: true}, 
        %{ field: "author", required: true}
      ]},
      %{ name: "comment", basetype: "string", validations: []},
      %{ name: "definition", basetype: "string", type: "map", validations: []},
      %{ name: "name", basetype: "string", validations: []},
      %{ name: "version", basetype: "string", validations: [%{ type: "format", rule: "^(?! )((?!  )(?! $)[a-zA-Z ]){3,50}$"}] },
      %{ name: "author", basetype: "id", validations: []}
    ]}
  end
end
