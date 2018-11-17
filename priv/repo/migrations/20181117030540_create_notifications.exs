defmodule Project.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :user_id, :integer
      add :description, :text

      timestamps()
    end

  end
end
