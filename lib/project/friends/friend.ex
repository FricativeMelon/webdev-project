defmodule Project.Friends.Friend do
  use Ecto.Schema
  import Ecto.Changeset


  schema "friends" do
    field :status, :integer
    belongs_to :user, Project.Users.User
    belongs_to :friend, Project.Users.User

    timestamps()
  end

  @doc false
  def changeset(friend, attrs) do
    friend
    |> cast(attrs, [:status, :user_id, :friend_id])
    |> validate_required([:status, :user_id, :friend_id])
  end
end
