defmodule FormManager.Forms.Form do
  use Ecto.Schema
  import Ecto.Changeset

  schema "forms" do
    field :author, :string
    field :name, :string
    field :version, :string
    field :definition, :map
    timestamps()
  end

  @doc false
  def changeset(form, attrs) do
    form
    |> cast(attrs, [:name, :version, :author, :definition])
    |> validate_required([:name, :version, :author, :definition])
  end
end
