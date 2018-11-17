defmodule Project.Repo.Migrations.CreateCalendars do
  use Ecto.Migration

  def change do
    create table(:calendars) do
      add :timestamp, :date

      timestamps()
    end

  end
end
