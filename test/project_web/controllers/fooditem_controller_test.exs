defmodule ProjectWeb.FooditemControllerTest do
  use ProjectWeb.ConnCase

  alias Project.Fooditems

  @create_attrs %{name: "some name", nutrition_id: 42}
  @update_attrs %{name: "some updated name", nutrition_id: 43}
  @invalid_attrs %{name: nil, nutrition_id: nil}

  def fixture(:fooditem) do
    {:ok, fooditem} = Fooditems.create_fooditem(@create_attrs)
    fooditem
  end

  describe "index" do
    test "lists all fooditems", %{conn: conn} do
      conn = get(conn, Routes.fooditem_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fooditems"
    end
  end

  describe "new fooditem" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fooditem_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fooditem"
    end
  end

  describe "create fooditem" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fooditem_path(conn, :create), fooditem: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fooditem_path(conn, :show, id)

      conn = get(conn, Routes.fooditem_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fooditem"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fooditem_path(conn, :create), fooditem: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fooditem"
    end
  end

  describe "edit fooditem" do
    setup [:create_fooditem]

    test "renders form for editing chosen fooditem", %{conn: conn, fooditem: fooditem} do
      conn = get(conn, Routes.fooditem_path(conn, :edit, fooditem))
      assert html_response(conn, 200) =~ "Edit Fooditem"
    end
  end

  describe "update fooditem" do
    setup [:create_fooditem]

    test "redirects when data is valid", %{conn: conn, fooditem: fooditem} do
      conn = put(conn, Routes.fooditem_path(conn, :update, fooditem), fooditem: @update_attrs)
      assert redirected_to(conn) == Routes.fooditem_path(conn, :show, fooditem)

      conn = get(conn, Routes.fooditem_path(conn, :show, fooditem))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, fooditem: fooditem} do
      conn = put(conn, Routes.fooditem_path(conn, :update, fooditem), fooditem: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fooditem"
    end
  end

  describe "delete fooditem" do
    setup [:create_fooditem]

    test "deletes chosen fooditem", %{conn: conn, fooditem: fooditem} do
      conn = delete(conn, Routes.fooditem_path(conn, :delete, fooditem))
      assert redirected_to(conn) == Routes.fooditem_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.fooditem_path(conn, :show, fooditem))
      end
    end
  end

  defp create_fooditem(_) do
    fooditem = fixture(:fooditem)
    {:ok, fooditem: fooditem}
  end
end
