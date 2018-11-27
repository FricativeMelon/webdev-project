defmodule Project.Calendars.Calendar do
  use Ecto.Schema
  import Ecto.Changeset


  schema "calendars" do
    field :timestamp, :date

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [:timestamp])
    |> validate_required([:timestamp])
  end
end
