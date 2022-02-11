defmodule Yic.Repo.Migrations.UpdateApisTabls do
  use Ecto.Migration

  def change do
    alter table(:apis) do
      modify :definition, :text
    end
  end

end
