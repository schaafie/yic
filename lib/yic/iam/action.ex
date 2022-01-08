defmodule Yic.Iam.Action do
  use Ecto.Schema
  import Ecto.Changeset

  schema "actions" do
    field :comment, :string
    field :name, :string
    field :url, :string
    field :system_id, :id

    timestamps()
  end

  @doc false
  def changeset(action, attrs) do
    action
    |> cast(attrs, [:name, :comment, :url])
    |> validate_required([:name, :comment, :url])
  end
end
