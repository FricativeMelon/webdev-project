defmodule Project.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :friend_id, :integer

      timestamps()
    end

      create index(:friends, [:user_id])
  end
end
