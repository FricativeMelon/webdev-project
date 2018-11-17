defmodule Project.PreferencesTest do
  use Project.DataCase

  alias Project.Preferences

  describe "preferences" do
    alias Project.Preferences.Preference

    @valid_attrs %{notify_freq: "some notify_freq", privacy: true}
    @update_attrs %{notify_freq: "some updated notify_freq", privacy: false}
    @invalid_attrs %{notify_freq: nil, privacy: nil}

    def preference_fixture(attrs \\ %{}) do
      {:ok, preference} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Preferences.create_preference()

      preference
    end

    test "list_preferences/0 returns all preferences" do
      preference = preference_fixture()
      assert Preferences.list_preferences() == [preference]
    end

    test "get_preference!/1 returns the preference with given id" do
      preference = preference_fixture()
      assert Preferences.get_preference!(preference.id) == preference
    end

    test "create_preference/1 with valid data creates a preference" do
      assert {:ok, %Preference{} = preference} = Preferences.create_preference(@valid_attrs)
      assert preference.notify_freq == "some notify_freq"
      assert preference.privacy == true
    end

    test "create_preference/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Preferences.create_preference(@invalid_attrs)
    end

    test "update_preference/2 with valid data updates the preference" do
      preference = preference_fixture()
      assert {:ok, %Preference{} = preference} = Preferences.update_preference(preference, @update_attrs)
      assert preference.notify_freq == "some updated notify_freq"
      assert preference.privacy == false
    end

    test "update_preference/2 with invalid data returns error changeset" do
      preference = preference_fixture()
      assert {:error, %Ecto.Changeset{}} = Preferences.update_preference(preference, @invalid_attrs)
      assert preference == Preferences.get_preference!(preference.id)
    end

    test "delete_preference/1 deletes the preference" do
      preference = preference_fixture()
      assert {:ok, %Preference{}} = Preferences.delete_preference(preference)
      assert_raise Ecto.NoResultsError, fn -> Preferences.get_preference!(preference.id) end
    end

    test "change_preference/1 returns a preference changeset" do
      preference = preference_fixture()
      assert %Ecto.Changeset{} = Preferences.change_preference(preference)
    end
  end
end
