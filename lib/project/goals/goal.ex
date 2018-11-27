defmodule Project.Goals.Goal do
  use Ecto.Schema
  import Ecto.Changeset


  schema "goals" do
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:description])
    |> validate_required(:description)
  end
end