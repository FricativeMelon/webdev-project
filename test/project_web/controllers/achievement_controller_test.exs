defmodule ProjectWeb.AchievementControllerTest do
  use ProjectWeb.ConnCase

  alias Project.Achievements

  @create_attrs %{achievement_name: "some achievement_name", user_id: 42}
  @update_attrs %{achievement_name: "some updated achievement_name", user_id: 43}
  @invalid_attrs %{achievement_name: nil, user_id: nil}

  def fixture(:achievement) do
    {:ok, achievement} = Achievements.create_achievement(@create_attrs)
    achievement
  end

  describe "index" do
    test "lists all achievements", %{conn: conn} do
      conn = get(conn, Routes.achievement_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Achievements"
    end
  end

  describe "new achievement" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.achievement_path(conn, :new))
      assert html_response(conn, 200) =~ "New Achievement"
    end
  end

  describe "create achievement" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.achievement_path(conn, :create), achievement: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.achievement_path(conn, :show, id)

      conn = get(conn, Routes.achievement_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Achievement"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.achievement_path(conn, :create), achievement: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Achievement"
    end
  end

  describe "edit achievement" do
    setup [:create_achievement]

    test "renders form for editing chosen achievement", %{conn: conn, achievement: achievement} do
      conn = get(conn, Routes.achievement_path(conn, :edit, achievement))
      assert html_response(conn, 200) =~ "Edit Achievement"
    end
  end

  describe "update achievement" do
    setup [:create_achievement]

    test "redirects when data is valid", %{conn: conn, achievement: achievement} do
      conn = put(conn, Routes.achievement_path(conn, :update, achievement), achievement: @update_attrs)
      assert redirected_to(conn) == Routes.achievement_path(conn, :show, achievement)

      conn = get(conn, Routes.achievement_path(conn, :show, achievement))
      assert html_response(conn, 200) =~ "some updated achievement_name"
    end

    test "renders errors when data is invalid", %{conn: conn, achievement: achievement} do
      conn = put(conn, Routes.achievement_path(conn, :update, achievement), achievement: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Achievement"
    end
  end

  describe "delete achievement" do
    setup [:create_achievement]

    test "deletes chosen achievement", %{conn: conn, achievement: achievement} do
      conn = delete(conn, Routes.achievement_path(conn, :delete, achievement))
      assert redirected_to(conn) == Routes.achievement_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.achievement_path(conn, :show, achievement))
      end
    end
  end

  defp create_achievement(_) do
    achievement = fixture(:achievement)
    {:ok, achievement: achievement}
  end
end
