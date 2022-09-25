defmodule Yic.Repo.Migrations.CreateDatadefs do
  use Ecto.Migration

  def change do
    create table(:datadefs) do
      add :name, :string
      add :comment, :string
      add :version, :string
      add :definition, :map

      timestamps()
    end
  end
end
