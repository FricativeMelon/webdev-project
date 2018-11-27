defmodule Project.Repo.Migrations.CreateFooditems do
  use Ecto.Migration

  def change do
    create table(:fooditems) do
      add :name, :text
      add :nutrition_id, :integer
      add :datetime, :timestamp
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :nutrients, {:array, :map}, default: []

      timestamps()
    end

  end
end
