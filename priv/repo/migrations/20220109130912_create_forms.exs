defmodule Yic.Repo.Migrations.CreateForms do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :name, :string
      add :comment, :string
      add :version, :string
      add :definition, :string
      add :author, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:forms, [:author])
  end
end
