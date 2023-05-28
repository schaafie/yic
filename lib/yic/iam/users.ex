defmodule Yic.Iam.Users do
  use Ecto.Schema
  import Ecto.Changeset
  alias Yic.Json

  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :details, Json

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:firstname, :lastname, :email, :details])
    |> validate_required([:firstname, :lastname, :email])
  end
end
