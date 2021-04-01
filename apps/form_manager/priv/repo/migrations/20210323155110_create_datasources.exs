defmodule FormManager.Repo.Migrations.CreateDatasources do
  use Ecto.Migration

  def change do
    create table(:datasources) do
      add :name, :string
      add :comment, :string
      add :version, :string
      add :definition, :map
      add :actions, :map

      timestamps()
    end

  end
end
