defmodule Yic.Apis.Api do
  use Ecto.Schema
  import Ecto.Changeset
  alias Yic.Json

  schema "apis" do
    field :definition, Json
    field :description, :string
    field :name, :string
    field :request, :string
    field :version, Json

    timestamps()
  end

  @doc false
  def changeset(api, attrs) do
    api
    |> cast(attrs, [:name, :description, :version, :request, :definition])
    |> validate_required([:name, :description, :version, :request, :definition])
  end

  # def valdiate_json(changeset, field, options \\ []) do
  #   validate_change(changeset, field, fn _, definition ->
  #     case Poison.decode(definition) do
  #       {:ok, _map} -> 
  #         []
  #       {:error, _exception} ->
  #         [{field, options[:message] || "Invalid JSON"}]
  #     end
  #   end)
  # end
end
