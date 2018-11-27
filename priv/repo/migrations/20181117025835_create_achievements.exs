defmodule Project.Repo.Migrations.CreateAchievements do
  use Ecto.Migration

  def change do
    create table(:achievements) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :achievement_name, :text

      timestamps()
    end

    create index(:achievements, [:user_id])

  end
end
