defmodule Project.Achievements.Achievement do
  use Ecto.Schema
  import Ecto.Changeset


  schema "achievements" do
    field :achievement_name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(achievement, attrs) do
    achievement
    |> cast(attrs, [:user_id, :achievement_name])
    |> validate_required([:user_id, :achievement_name])
  end
end
