defmodule Yic.Repo.Migrations.CreateAllows do
  use Ecto.Migration

  def change do
    create table(:allows) do
      add :account_id, references(:accounts, on_delete: :nothing)
      add :role_id, references(:roles, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)
      add :action_id, references(:actions, on_delete: :nothing)

      timestamps()
    end

    create index(:allows, [:account_id])
    create index(:allows, [:role_id])
    create index(:allows, [:group_id])
    create index(:allows, [:action_id])
  end
end
