defmodule ProjectWeb.FriendController do
  use ProjectWeb, :controller

  alias Project.Friends
  alias Project.Friends.Friend

  def index(conn, _params) do
    friends = Enum.map(Friends.list_friends(), fn ff -> Project.Users.get_user!(ff.friend_id).email end)
    render(conn, "index.html", friends: friends)
  end

  def new(conn, _params) do
    changeset = Friends.change_friend(%Friend{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"requester" => requester, "accepter" => accepter}) do
    req_user = Project.Users.get_user_by_email(requester)
    acc_user = Project.Users.get_user_by_email(accepter)
    case Friends.create_friend(%{"status" => 0, "user_id" => req_user.id, "friend_id" => acc_user.id}) do
      {:ok, friend} ->
        conn
        |> put_flash(:info, "Friend created successfully.")
        |> redirect(to: Routes.friend_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    friend = Friends.get_friend!(id)
    render(conn, "show.html", friend: friend)
  end

  def edit(conn, %{"id" => id}) do
    friend = Friends.get_friend!(id)
    changeset = Friends.change_friend(friend)
    render(conn, "edit.html", friend: friend, changeset: changeset)
  end

  def update(conn, %{"id" => id, "friend" => friend_params}) do
    friend = Friends.get_friend!(id)

    case Friends.update_friend(friend, friend_params) do
      {:ok, friend} ->
        conn
        |> put_flash(:info, "Friend updated successfully.")
        |> redirect(to: Routes.friend_path(conn, :show, friend))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", friend: friend, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    friend = Friends.get_friend!(id)
    {:ok, _friend} = Friends.delete_friend(friend)

    conn
    |> put_flash(:info, "Friend deleted successfully.")
    |> redirect(to: Routes.friend_path(conn, :index))
  end
end
