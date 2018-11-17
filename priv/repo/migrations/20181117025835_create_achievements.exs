defmodule Project.Repo.Migrations.CreateAchievements do
  use Ecto.Migration

  def change do
    create table(:achievements) do
      add :user_id, :integer
      add :achievement_name, :text

      timestamps()
    end

  end
end
