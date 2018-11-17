defmodule Project.Fooditems do
  @moduledoc """
  The Fooditems context.
  """

  import Ecto.Query, warn: false
  alias Project.Repo

  alias Project.Fooditems.Fooditem

  @doc """
  Returns the list of fooditems.

  ## Examples

      iex> list_fooditems()
      [%Fooditem{}, ...]

  """
  def list_fooditems do
    Repo.all(Fooditem)
  end

  @doc """
  Gets a single fooditem.

  Raises `Ecto.NoResultsError` if the Fooditem does not exist.

  ## Examples

      iex> get_fooditem!(123)
      %Fooditem{}

      iex> get_fooditem!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fooditem!(id), do: Repo.get!(Fooditem, id)

  @doc """
  Creates a fooditem.

  ## Examples

      iex> create_fooditem(%{field: value})
      {:ok, %Fooditem{}}

      iex> create_fooditem(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fooditem(attrs \\ %{}) do
    %Fooditem{}
    |> Fooditem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fooditem.

  ## Examples

      iex> update_fooditem(fooditem, %{field: new_value})
      {:ok, %Fooditem{}}

      iex> update_fooditem(fooditem, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fooditem(%Fooditem{} = fooditem, attrs) do
    fooditem
    |> Fooditem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Fooditem.

  ## Examples

      iex> delete_fooditem(fooditem)
      {:ok, %Fooditem{}}

      iex> delete_fooditem(fooditem)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fooditem(%Fooditem{} = fooditem) do
    Repo.delete(fooditem)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fooditem changes.

  ## Examples

      iex> change_fooditem(fooditem)
      %Ecto.Changeset{source: %Fooditem{}}

  """
  def change_fooditem(%Fooditem{} = fooditem) do
    Fooditem.changeset(fooditem, %{})
  end
end
