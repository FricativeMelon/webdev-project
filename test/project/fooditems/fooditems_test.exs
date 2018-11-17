defmodule Project.FooditemsTest do
  use Project.DataCase

  alias Project.Fooditems

  describe "fooditems" do
    alias Project.Fooditems.Fooditem

    @valid_attrs %{name: "some name", nutrition_id: 42}
    @update_attrs %{name: "some updated name", nutrition_id: 43}
    @invalid_attrs %{name: nil, nutrition_id: nil}

    def fooditem_fixture(attrs \\ %{}) do
      {:ok, fooditem} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fooditems.create_fooditem()

      fooditem
    end

    test "list_fooditems/0 returns all fooditems" do
      fooditem = fooditem_fixture()
      assert Fooditems.list_fooditems() == [fooditem]
    end

    test "get_fooditem!/1 returns the fooditem with given id" do
      fooditem = fooditem_fixture()
      assert Fooditems.get_fooditem!(fooditem.id) == fooditem
    end

    test "create_fooditem/1 with valid data creates a fooditem" do
      assert {:ok, %Fooditem{} = fooditem} = Fooditems.create_fooditem(@valid_attrs)
      assert fooditem.name == "some name"
      assert fooditem.nutrition_id == 42
    end

    test "create_fooditem/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fooditems.create_fooditem(@invalid_attrs)
    end

    test "update_fooditem/2 with valid data updates the fooditem" do
      fooditem = fooditem_fixture()
      assert {:ok, %Fooditem{} = fooditem} = Fooditems.update_fooditem(fooditem, @update_attrs)
      assert fooditem.name == "some updated name"
      assert fooditem.nutrition_id == 43
    end

    test "update_fooditem/2 with invalid data returns error changeset" do
      fooditem = fooditem_fixture()
      assert {:error, %Ecto.Changeset{}} = Fooditems.update_fooditem(fooditem, @invalid_attrs)
      assert fooditem == Fooditems.get_fooditem!(fooditem.id)
    end

    test "delete_fooditem/1 deletes the fooditem" do
      fooditem = fooditem_fixture()
      assert {:ok, %Fooditem{}} = Fooditems.delete_fooditem(fooditem)
      assert_raise Ecto.NoResultsError, fn -> Fooditems.get_fooditem!(fooditem.id) end
    end

    test "change_fooditem/1 returns a fooditem changeset" do
      fooditem = fooditem_fixture()
      assert %Ecto.Changeset{} = Fooditems.change_fooditem(fooditem)
    end
  end
end
