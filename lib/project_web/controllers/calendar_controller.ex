defmodule ProjectWeb.CalendarController do
  use ProjectWeb, :controller

  alias Project.Calendars
  alias Project.Calendars.Calendar

  def index(conn, _params) do
    calendars = Calendars.list_calendars()
    render(conn, "index.html", calendars: calendars)
  end

  def new(conn, _params) do
    changeset = Calendars.change_calendar(%Calendar{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"calendar" => calendar_params}) do
    case Calendars.create_calendar(calendar_params) do
      {:ok, calendar} ->
        conn
        |> put_flash(:info, "Calendar created successfully.")
        |> redirect(to: Routes.calendar_path(conn, :show, calendar))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    calendar = Calendars.get_calendar!(id)
    render(conn, "show.html", calendar: calendar)
  end

  def edit(conn, %{"id" => id}) do
    calendar = Calendars.get_calendar!(id)
    changeset = Calendars.change_calendar(calendar)
    render(conn, "edit.html", calendar: calendar, changeset: changeset)
  end

  def update(conn, %{"id" => id, "calendar" => calendar_params}) do
    calendar = Calendars.get_calendar!(id)

    case Calendars.update_calendar(calendar, calendar_params) do
      {:ok, calendar} ->
        conn
        |> put_flash(:info, "Calendar updated successfully.")
        |> redirect(to: Routes.calendar_path(conn, :show, calendar))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", calendar: calendar, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    calendar = Calendars.get_calendar!(id)
    {:ok, _calendar} = Calendars.delete_calendar(calendar)

    conn
    |> put_flash(:info, "Calendar deleted successfully.")
    |> redirect(to: Routes.calendar_path(conn, :index))
  end
end
