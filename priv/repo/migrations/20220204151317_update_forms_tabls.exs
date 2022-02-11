defmodule Yic.Repo.Migrations.UpdateFormsTabls do
  use Ecto.Migration

  def change do
    alter table(:forms) do
      modify :definition, :text
    end
  end

end
