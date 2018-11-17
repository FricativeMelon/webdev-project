defmodule Project.Fooditems.Fooditem do
  use Ecto.Schema
  import Ecto.Changeset


  schema "fooditems" do
    field :name, :string
    field :nutrition_id, :integer

    timestamps()
  end

  @doc false
  def changeset(fooditem, attrs) do
    fooditem
    |> cast(attrs, [:name, :nutrition_id])
    |> validate_required([:name, :nutrition_id])
  end
end
