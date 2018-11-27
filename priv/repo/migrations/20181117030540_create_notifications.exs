defmodule Project.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :description, :text

      timestamps()
    end

    create index(:notifications, [:user_id])

  end
end
