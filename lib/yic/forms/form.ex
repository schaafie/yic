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
end
