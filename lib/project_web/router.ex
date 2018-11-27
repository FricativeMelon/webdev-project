defmodule ProjectWeb.Router do
  use ProjectWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ProjectWeb.Plugs.FetchSession
    plug :put_user_token
    end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end


  pipeline :ajax do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug ProjectWeb.Plugs.FetchSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/ajax", ProjectWeb do
    pipe_through :ajax
 
    resources "/friends", FriendController
  end

  scope "/", ProjectWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/friends", FriendController
    resources "/preferences", PreferenceController
    resources "/achievements", AchievementController
    resources "/goals", GoalController
    resources "/fooditems", FooditemController
    resources "/notifications", NotificationController
    resources "/calendars", CalendarController
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
    post "/join", PageController, :join
    get "/game/:game", PageController, :game
  end

  # Other scopes may use custom stacks.
  scope "/api", ProjectWeb do
    pipe_through :api
    get "/edamam/:id", EdamamController, :show
  end
end
