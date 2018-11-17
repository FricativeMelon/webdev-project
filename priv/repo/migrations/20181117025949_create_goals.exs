defmodule Project.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :user_id, :integer
      add :description, :text

      timestamps()
    end

  end
end
