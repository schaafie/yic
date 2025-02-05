defmodule Yic.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :token, :map
      add :flow_id, references(:flows, on_delete: :nothing)
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tokens, [:flow_id])
    create index(:tokens, [:owner])
  end
end
