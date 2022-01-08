defmodule Yic.Repo.Migrations.CreateDatasources do
  use Ecto.Migration

  def change do
    create table(:datasources) do
      add :name, :string
      add :comment, :string
      add :version, :string
      add :definition, :string
      add :actions, {:array, :string}

      timestamps()
    end
  end
end
