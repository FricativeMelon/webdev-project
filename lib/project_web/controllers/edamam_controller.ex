defmodule ProjectWeb.EdamamController do
  use ProjectWeb, :controller

  def edamam_query(string) do
    api_key = "63ac04eed062f0d6b056cc480e588793"
    api_id = "3c65383e"

    HTTPoison.get("https://api.edamam.com/api/food-database/parser", [], params:
 %{ingr: string, app_id: api_id, app_key: api_key})
    |> get_nutrients()
  end

  def get_nutrients(response) do
    if elem(response, 0) == :ok do
      Map.get(elem(response, 1), :body)
      |> get_food_item_list_from_json()
      |> remove_duplicate_names()
    else
      []
    end
  end

  def remove_duplicate_names(foodList) do
    IO.inspect(foodList)
    Enum.uniq_by(foodList, fn x -> Map.get(x, :name) end)
  end

  def get_food_item_list_from_json(json) do
    Jason.decode!(json)
    |> Map.get("hints")
    |> Enum.map(fn x -> %{"name": Map.get(Map.get(x, "food", %{}), "label", "UNKNOWN") <> " // " <> Map.get(Map.get(x, "food", %{}), "brand", "UNKNOWN"), "nutrition": Map.get(Map.get(x, "food", %{}), "nutrients", %{}), "active": false}end)
  end

  def show(conn, %{"id" => id}) do
    IO.inspect(id)
    out = edamam_query(id)
    json(conn, out)
  end
end
