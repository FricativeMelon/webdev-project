defmodule Project.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :status, :integer, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :friend_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:friends, [:user_id])
    create index(:friends, [:friend_id])
    create index(:friends, [:user_id, :friend_id], unique: true)
  end
end

