defmodule FormManager.Repo.Migrations.CreateForms do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :name, :string
      add :version, :string
      add :author, :string
      add :definition, :map

      timestamps()
    end

  end
end
