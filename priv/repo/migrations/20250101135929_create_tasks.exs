defmodule Yic.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :can_do, :map
      add :flow_id, references(:flows, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:flow_id])
  end
end
