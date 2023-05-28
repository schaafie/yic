defmodule Yic.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :description, :string
      add :version, :map
      add :content, :map
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:items, [:owner])
  end
end
