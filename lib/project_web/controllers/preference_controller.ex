defmodule ProjectWeb.PreferenceController do
  use ProjectWeb, :controller

  alias Project.Preferences
  alias Project.Preferences.Preference

  def index(conn, _params) do
    preferences = Preferences.list_preferences()
    render(conn, "index.html", preferences: preferences)
  end

  def new(conn, _params) do
    changeset = Preferences.change_preference(%Preference{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"preference" => preference_params}) do
    case Preferences.create_preference(preference_params) do
      {:ok, preference} ->
        conn
        |> put_flash(:info, "Preference created successfully.")
        |> redirect(to: Routes.preference_path(conn, :show, preference))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    preference = Preferences.get_preference!(id)
    render(conn, "show.html", preference: preference)
  end

  def edit(conn, %{"id" => id}) do
    preference = Preferences.get_preference!(id)
    changeset = Preferences.change_preference(preference)
    render(conn, "edit.html", preference: preference, changeset: changeset)
  end

  def update(conn, %{"id" => id, "preference" => preference_params}) do
    preference = Preferences.get_preference!(id)

    case Preferences.update_preference(preference, preference_params) do
      {:ok, preference} ->
        conn
        |> put_flash(:info, "Preference updated successfully.")
        |> redirect(to: Routes.preference_path(conn, :show, preference))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", preference: preference, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    preference = Preferences.get_preference!(id)
    {:ok, _preference} = Preferences.delete_preference(preference)

    conn
    |> put_flash(:info, "Preference deleted successfully.")
    |> redirect(to: Routes.preference_path(conn, :index))
  end
end
