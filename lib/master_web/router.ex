defmodule MasterWeb.Router do
  use MasterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MasterWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/master", GameLive
    live "/timer", TimerLive
    live "/link", LinkLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", MasterWeb do
  #   pipe_through :api
  # end
end
