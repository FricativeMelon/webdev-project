defmodule ProjectWeb.FooditemController do
  use ProjectWeb, :controller

  alias Project.Fooditems
  alias Project.Fooditems.Fooditem

  def index(conn, _params) do
    fooditems = Fooditems.list_fooditems()
    render(conn, "index.html", fooditems: fooditems)
  end

  def new(conn, _params) do
    changeset = Fooditems.change_fooditem(%Fooditem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fooditem" => fooditem_params}) do
    case Fooditems.create_fooditem(fooditem_params) do
      {:ok, fooditem} ->
        conn
        |> put_flash(:info, "Fooditem created successfully.")
        |> redirect(to: Routes.fooditem_path(conn, :show, fooditem))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fooditem = Fooditems.get_fooditem!(id)
    render(conn, "show.html", fooditem: fooditem)
  end

  def edit(conn, %{"id" => id}) do
    fooditem = Fooditems.get_fooditem!(id)
    changeset = Fooditems.change_fooditem(fooditem)
    render(conn, "edit.html", fooditem: fooditem, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fooditem" => fooditem_params}) do
    fooditem = Fooditems.get_fooditem!(id)

    case Fooditems.update_fooditem(fooditem, fooditem_params) do
      {:ok, fooditem} ->
        conn
        |> put_flash(:info, "Fooditem updated successfully.")
        |> redirect(to: Routes.fooditem_path(conn, :show, fooditem))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fooditem: fooditem, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fooditem = Fooditems.get_fooditem!(id)
    {:ok, _fooditem} = Fooditems.delete_fooditem(fooditem)

    conn
    |> put_flash(:info, "Fooditem deleted successfully.")
    |> redirect(to: Routes.fooditem_path(conn, :index))
  end
end
