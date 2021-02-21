defmodule PublicationManager.Repo.Migrations.CreatePublications do
  use Ecto.Migration

  def change do
    create table(:publications) do
      add :target, :integer
      add :path, :string
      add :version, :string
      add :definition, :string
      add :start, :utc_datetime
      add :end, :utc_datetime

      timestamps()
    end

  end
end
