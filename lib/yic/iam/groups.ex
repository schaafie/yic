defmodule Yic.Iam.Groups do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :comment, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(groups, attrs) do
    groups
    |> cast(attrs, [:name, :comment])
    |> validate_required([:name, :comment])
  end
end
