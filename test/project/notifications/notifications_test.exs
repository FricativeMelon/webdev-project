defmodule Project.NotificationsTest do
  use Project.DataCase

  alias Project.Notifications

  describe "notifications" do
    alias Project.Notifications.Notification

    @valid_attrs %{description: "some description", user_id: 42}
    @update_attrs %{description: "some updated description", user_id: 43}
    @invalid_attrs %{description: nil, user_id: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Notifications.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Notifications.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Notifications.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Notifications.create_notification(@valid_attrs)
      assert notification.description == "some description"
      assert notification.user_id == 42
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notifications.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{} = notification} = Notifications.update_notification(notification, @update_attrs)
      assert notification.description == "some updated description"
      assert notification.user_id == 43
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Notifications.update_notification(notification, @invalid_attrs)
      assert notification == Notifications.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Notifications.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Notifications.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Notifications.change_notification(notification)
    end
  end
end
