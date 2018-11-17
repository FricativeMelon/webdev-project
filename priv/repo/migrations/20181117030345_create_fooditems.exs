defmodule Project.Repo.Migrations.CreateFooditems do
  use Ecto.Migration

  def change do
    create table(:fooditems) do
      add :name, :text
      add :nutrition_id, :integer

      timestamps()
    end

  end
end
