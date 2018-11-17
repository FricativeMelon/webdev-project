defmodule ProjectWeb.AchievementController do
  use ProjectWeb, :controller

  alias Project.Achievements
  alias Project.Achievements.Achievement

  def index(conn, _params) do
    achievements = Achievements.list_achievements()
    render(conn, "index.html", achievements: achievements)
  end

  def new(conn, _params) do
    changeset = Achievements.change_achievement(%Achievement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"achievement" => achievement_params}) do
    case Achievements.create_achievement(achievement_params) do
      {:ok, achievement} ->
        conn
        |> put_flash(:info, "Achievement created successfully.")
        |> redirect(to: Routes.achievement_path(conn, :show, achievement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    achievement = Achievements.get_achievement!(id)
    render(conn, "show.html", achievement: achievement)
  end

  def edit(conn, %{"id" => id}) do
    achievement = Achievements.get_achievement!(id)
    changeset = Achievements.change_achievement(achievement)
    render(conn, "edit.html", achievement: achievement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "achievement" => achievement_params}) do
    achievement = Achievements.get_achievement!(id)

    case Achievements.update_achievement(achievement, achievement_params) do
      {:ok, achievement} ->
        conn
        |> put_flash(:info, "Achievement updated successfully.")
        |> redirect(to: Routes.achievement_path(conn, :show, achievement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", achievement: achievement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    achievement = Achievements.get_achievement!(id)
    {:ok, _achievement} = Achievements.delete_achievement(achievement)

    conn
    |> put_flash(:info, "Achievement deleted successfully.")
    |> redirect(to: Routes.achievement_path(conn, :index))
  end
end
