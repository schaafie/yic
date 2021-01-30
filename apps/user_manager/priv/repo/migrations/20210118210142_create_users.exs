defmodule UserManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string
      add :password, :string
      add :email, :string
      add :firstname, :string
      add :lastname, :string

      timestamps()
    end

  end
end
