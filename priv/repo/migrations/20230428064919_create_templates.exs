defmodule Yic.Repo.Migrations.CreateTemplates do
  use Ecto.Migration

  def change do
    create table(:templates) do
      add :name, :string
      add :description, :string
      add :version, :map
      add :definition, :map
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:templates, [:owner])
  end
end
