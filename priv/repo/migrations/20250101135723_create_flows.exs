defmodule Yic.Repo.Migrations.CreateFlows do
  use Ecto.Migration

  def change do
    create table(:flows) do
      add :name, :string
      add :description, :string
      add :version, :map
      add :definition, :map
      add :can_start, :map

      timestamps()
    end
  end
end
