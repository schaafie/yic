defmodule Yic.Repo.Migrations.CreateSystems do
  use Ecto.Migration

  def change do
    create table(:systems) do
      add :name, :string
      add :comment, :string
      add :host, :string

      timestamps()
    end
  end
end
