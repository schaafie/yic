defmodule Yic.Iam.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :login, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:firstname, :lastname, :email, :login, :password])
    |> validate_required([:firstname, :lastname, :email, :login, :password])
  end
end
