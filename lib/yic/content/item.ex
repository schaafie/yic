defmodule Yic.Content.Item do
  use Ecto.Schema
  import Ecto.Changeset
  import Yic.SchemaValidator
  alias Yic.Json
  
  schema "items" do
    field :content, Json
    field :description, :string
    field :name, :string
    field :version, Json
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :version, :content])
    |> validate_changes_against_schema( "contentitem" )
  end
end
