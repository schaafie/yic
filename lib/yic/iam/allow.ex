defmodule Yic.Iam.Allow do
  use Ecto.Schema
  import Ecto.Changeset

  schema "allows" do

    field :user_id, :id
    field :role_id, :id
    field :group_id, :id
    field :action_id, :id

    timestamps()
  end

  @doc false
  def changeset(allow, attrs) do
    allow
    |> cast(attrs, [])
    |> validate_required([])
  end
end
