defmodule Yic.Iam.Denie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "denies" do

    field :account_id, :id
    field :role_id, :id
    field :group_id, :id
    field :action_id, :id

    timestamps()
  end

  @doc false
  def changeset(denie, attrs) do
    denie
    |> cast(attrs, [])
    |> validate_required([])
  end
end
