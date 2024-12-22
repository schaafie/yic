defmodule Yic.Content.Item do
  use Ecto.Schema
  import Ecto.Changeset
  import Yic.SchemaValidator
  alias Yic.Json
  
  schema "items" do
    field :content, :map # Json
    field :description, :string
    field :name, :string
    field :version, :map # Json
    field :template, :id
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :version, :content, :template, :owner])
    |> validate_changes_against_schema( "contentitem" )
  end
end
