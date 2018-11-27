defmodule Project.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :name, :string

    field :password_hash, :string


    many_to_many :friends, Project.Users.User, join_through: Project.Friends.Friend, join_keys: [user_id: :id, contact_id: :id]

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password, :password_confirmation])
    |> validate_confirmation(:password)
    |> validate_password(:password)
    |> put_pass_hash()
    |> validate_required([:email, :name, :password_hash])
  
  end

  def validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, password ->
      case validate_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  def put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
      change(changeset, Comeonin.Argon2.add_hash(password))
  end
  
  def put_pass_hash(changeset), do: changeset

  def validate_password?(password) when byte_size(password) > 3 do
    {:ok, password}
  end

  def validate_password?(_), do: {:error, "The password is too short"}


  


  
end
