defmodule Yic.Repo.Migrations.UpdateAccountsAuthTable do
  use Ecto.Migration

  def change do
    drop index(:accounts, [:email])

    alter table(:accounts) do
      add :login, :string
      add :user_id, references(:users, on_delete: :nothing)
      remove :email
    end

    create unique_index(:accounts, [:login])
    create index(:accounts, [:user_id])
  end
end
