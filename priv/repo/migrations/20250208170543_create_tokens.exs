defmodule Yic.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :current_task, :string
      add :can_do, :map
      add :flow_id, references(:flows, on_delete: :nothing)
      add :claimed_by, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tokens, [:flow_id])
    create index(:tokens, [:claimed_by])
  end
end
