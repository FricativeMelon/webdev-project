defmodule Project.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :description, :text

      timestamps()
    end
    create index(:goals, [:user_id])
  end
end

