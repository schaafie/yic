defmodule Yic.Repo.Migrations.CreateDenies do
  use Ecto.Migration

  def change do
    create table(:denies) do
      add :account_id, references(:accounts, on_delete: :nothing)
      add :role_id, references(:roles, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)
      add :action_id, references(:actions, on_delete: :nothing)

      timestamps()
    end

    create index(:denies, [:account_id])
    create index(:denies, [:role_id])
    create index(:denies, [:group_id])
    create index(:denies, [:action_id])
  end
end
