defmodule Project.Repo.Migrations.CreatePreferences do
  use Ecto.Migration

  def change do
    create table(:preferences) do
      add :privacy, :boolean, default: false, null: false
      add :notify_freq, :string

      timestamps()
    end

  end
end

