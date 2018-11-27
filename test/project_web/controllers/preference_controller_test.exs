defmodule ProjectWeb.PreferenceControllerTest do
  use ProjectWeb.ConnCase

  alias Project.Preferences

  @create_attrs %{notify_freq: "some notify_freq", privacy: true}
  @update_attrs %{notify_freq: "some updated notify_freq", privacy: false}
  @invalid_attrs %{notify_freq: nil, privacy: nil}

  def fixture(:preference) do
    {:ok, preference} = Preferences.create_preference(@create_attrs)
    preference
  end

  describe "index" do
    test "lists all preferences", %{conn: conn} do
      conn = get(conn, Routes.preference_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Preferences"
    end
  end

  describe "new preference" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.preference_path(conn, :new))
      assert html_response(conn, 200) =~ "New Preference"
    end
  end

  describe "create preference" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.preference_path(conn, :create), preference: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.preference_path(conn, :show, id)

      conn = get(conn, Routes.preference_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Preference"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.preference_path(conn, :create), preference: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Preference"
    end
  end

  describe "edit preference" do
    setup [:create_preference]

    test "renders form for editing chosen preference", %{conn: conn, preference: preference} do
      conn = get(conn, Routes.preference_path(conn, :edit, preference))
      assert html_response(conn, 200) =~ "Edit Preference"
    end
  end

  describe "update preference" do
    setup [:create_preference]

    test "redirects when data is valid", %{conn: conn, preference: preference} do
      conn = put(conn, Routes.preference_path(conn, :update, preference), preference: @update_attrs)
      assert redirected_to(conn) == Routes.preference_path(conn, :show, preference)

      conn = get(conn, Routes.preference_path(conn, :show, preference))
      assert html_response(conn, 200) =~ "some updated notify_freq"
    end

    test "renders errors when data is invalid", %{conn: conn, preference: preference} do
      conn = put(conn, Routes.preference_path(conn, :update, preference), preference: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Preference"
    end
  end

  describe "delete preference" do
    setup [:create_preference]

    test "deletes chosen preference", %{conn: conn, preference: preference} do
      conn = delete(conn, Routes.preference_path(conn, :delete, preference))
      assert redirected_to(conn) == Routes.preference_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.preference_path(conn, :show, preference))
      end
    end
  end

  defp create_preference(_) do
    preference = fixture(:preference)
    {:ok, preference: preference}
  end
end
