defmodule Project.Goals.Goal do
  use Ecto.Schema
  import Ecto.Changeset


  schema "goals" do
    field :description, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:user_id, :description])
    |> validate_required([:user_id, :description])
  end
end
