defmodule PublicationManager.Publications.Publication do
  use Ecto.Schema
  import Ecto.Changeset


  schema "publications" do
    field :target, :integer
    field :path, :string
    field :version, :string
    field :definition, :map, default: %{}
    field :end, :utc_datetime
    field :start, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(publication, attrs) do
    publication
    |> cast(attrs, [:target, :path, :version, :definition, :start, :end])
    |> validate_required([:target, :path, :version, :definition])
  end
end
