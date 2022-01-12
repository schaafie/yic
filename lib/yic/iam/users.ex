defmodule Yic.Iam.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:firstname, :lastname, :email])
    |> validate_required([:firstname, :lastname, :email])
  end
end
