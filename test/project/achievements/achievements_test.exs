defmodule Project.AchievementsTest do
  use Project.DataCase

  alias Project.Achievements

  describe "achievements" do
    alias Project.Achievements.Achievement

    @valid_attrs %{achievement_name: "some achievement_name", user_id: 42}
    @update_attrs %{achievement_name: "some updated achievement_name", user_id: 43}
    @invalid_attrs %{achievement_name: nil, user_id: nil}

    def achievement_fixture(attrs \\ %{}) do
      {:ok, achievement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Achievements.create_achievement()

      achievement
    end

    test "list_achievements/0 returns all achievements" do
      achievement = achievement_fixture()
      assert Achievements.list_achievements() == [achievement]
    end

    test "get_achievement!/1 returns the achievement with given id" do
      achievement = achievement_fixture()
      assert Achievements.get_achievement!(achievement.id) == achievement
    end

    test "create_achievement/1 with valid data creates a achievement" do
      assert {:ok, %Achievement{} = achievement} = Achievements.create_achievement(@valid_attrs)
      assert achievement.achievement_name == "some achievement_name"
      assert achievement.user_id == 42
    end

    test "create_achievement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Achievements.create_achievement(@invalid_attrs)
    end

    test "update_achievement/2 with valid data updates the achievement" do
      achievement = achievement_fixture()
      assert {:ok, %Achievement{} = achievement} = Achievements.update_achievement(achievement, @update_attrs)
      assert achievement.achievement_name == "some updated achievement_name"
      assert achievement.user_id == 43
    end

    test "update_achievement/2 with invalid data returns error changeset" do
      achievement = achievement_fixture()
      assert {:error, %Ecto.Changeset{}} = Achievements.update_achievement(achievement, @invalid_attrs)
      assert achievement == Achievements.get_achievement!(achievement.id)
    end

    test "delete_achievement/1 deletes the achievement" do
      achievement = achievement_fixture()
      assert {:ok, %Achievement{}} = Achievements.delete_achievement(achievement)
      assert_raise Ecto.NoResultsError, fn -> Achievements.get_achievement!(achievement.id) end
    end

    test "change_achievement/1 returns a achievement changeset" do
      achievement = achievement_fixture()
      assert %Ecto.Changeset{} = Achievements.change_achievement(achievement)
    end
  end
end
