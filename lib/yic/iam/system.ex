defmodule Yic.Iam.System do
  use Ecto.Schema
  import Ecto.Changeset

  schema "systems" do
    field :comment, :string
    field :host, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(system, attrs) do
    system
    |> cast(attrs, [:name, :comment, :host])
    |> validate_required([:name, :comment, :host])
  end
end
