defmodule ProjectWeb.Router do
  use ProjectWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ProjectWeb.Plugs.PutUserToken
    plug ProjectWeb.Plugs.FetchSession
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


  scope "/", ProjectWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/preferences", PreferenceController
    resources "/achievements", AchievementController
    resources "/goals", GoalController
    resources "/fooditems", FooditemController
    resources "/notifications", NotificationController
    resources "/friends", FriendController
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
