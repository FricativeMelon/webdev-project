defmodule Project.Friends.Friend do
  use Ecto.Schema
  import Ecto.Changeset


  schema "friends" do
    field :friend_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(friend, attrs) do
    friend
    |> cast(attrs, [:user_id, :friend_id])
    |> validate_required([:user_id, :friend_id])
  end
end
