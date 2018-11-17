defmodule Project.Preferences.Preference do
  use Ecto.Schema
  import Ecto.Changeset


  schema "preferences" do
    field :notify_freq, :string
    field :privacy, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(preference, attrs) do
    preference
    |> cast(attrs, [:privacy, :notify_freq])
    |> validate_required([:privacy, :notify_freq])
  end
end
