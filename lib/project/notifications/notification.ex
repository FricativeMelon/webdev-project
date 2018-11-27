defmodule Project.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset


  schema "notifications" do
    field :description, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:user_id, :description])
    |> validate_required([:user_id, :description])
  end
end
