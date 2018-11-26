defmodule Project.Fooditems.Fooditem do
  use Ecto.Schema
  import Ecto.Changeset


  schema "fooditems" do
    field :name, :string
    field :datetime, :integer
    field :user_id, :integer
    embeds_many :nutrients, Nutrients

    timestamps()
  end

  @doc false
  def changeset(fooditem, attrs) do
    fooditem
    |> cast(attrs, [:name, :nutrition_id])
    |> validate_required([:name, :nutrition_id])
  end
end


defmodule Nutrients do
  use Ecto.Schema

  embedded_schema do
    field :CA
    field :ENERC_KCAL
    field :CHOCDF
    field :NIA
    field :CHOLE
    field :P
    field :FAMS
    field :PROCNT
    field :FAPU
    field :RIBF
    field :SUGAR
    field :SUGARadded
    field :FAT
    field :FASAT
    field :FATRN
    field :TOCPHA
    field :FE
    field :VITA_RAE
    field :FIBTG
    field :VITB12
    field :FOLDFE
    field :FOLFD
    field :K
    field :VITC
    field :MG
    field :VITD
    field :NA
    field :VITK1
    field :VITB6A
    field :THIA

  end
end