defmodule PublicationManager.Publications.Publication do
  use Ecto.Schema
  import Ecto.Changeset


  schema "publications" do
    field :definition, :string
    field :end, :utc_datetime
    field :path, :string
    field :start, :utc_datetime
    field :target, :integer
    field :version, :string

    timestamps()
  end

  @doc false
  def changeset(publication, attrs) do
    publication
    |> cast(attrs, [:target, :path, :version, :definition, :start, :end])
    |> validate_required([:target, :path, :version, :definition, :start, :end])
  end
end
