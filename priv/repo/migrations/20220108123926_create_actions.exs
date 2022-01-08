defmodule Yic.Repo.Migrations.CreateActions do
  use Ecto.Migration

  def change do
    create table(:actions) do
      add :name, :string
      add :comment, :string
      add :url, :string
      add :system_id, references(:systems, on_delete: :nothing)

      timestamps()
    end

    create index(:actions, [:system_id])
  end
end
