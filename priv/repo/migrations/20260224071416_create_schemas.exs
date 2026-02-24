defmodule Yic.Repo.Migrations.CreateSchemas do
  use Ecto.Migration

  def change do
    create table(:schemas) do
      add :name, :string
      add :description, :string
      add :version, :map
      add :definition, :map

      timestamps()
    end
  end
end
