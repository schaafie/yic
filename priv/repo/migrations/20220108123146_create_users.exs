defmodule Yic.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :email, :string
      add :login, :string
      add :password, :string

      timestamps()
    end
  end
end
