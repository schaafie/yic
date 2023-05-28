defmodule Yic.Content.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :content, :map
    field :description, :string
    field :name, :string
    field :version, :map
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :version, :content])
    |> validate_required([:name, :description, :version, :content])
  end
end
