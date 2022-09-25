defmodule Yic.Repo.Migrations.CreateApis do
  use Ecto.Migration

  def change do
    create table(:apis) do
      add :name, :string
      add :description, :string
      add :version, :string
      add :request, :string
      add :definition, :map

      timestamps()
    end
  end
end
