defmodule Yic.Forms.Form do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> cast(attrs, [:name, :comment, :version, :definition])
    |> validate_required([:name, :comment, :version, :definition])
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
      %{ name: "comment", basetype: "string"},
      %{ name: "definition", basetype:  "string", type: "map"},
      %{ name: "name", basetype: "string"},
      %{ name: "version", basetype: "string"},
      %{ name: "author", basetype: "id"}
    ]}
  end
end
