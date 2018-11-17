defmodule Project.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :user_id, :integer
      add :friend_id, :integer

      timestamps()
    end

  end
end
