defmodule Project.Repo.Migrations.CreateCalendars do
    use Ecto.Migration
  
    def change do
      create table(:calendars) do
        add :timestamp, :date
        add :user_id, references(:users, on_delete: :delete_all), null: false
  
        timestamps()
      end
      create index(:calendars, [:user_id])
    end
  end