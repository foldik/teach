defmodule TeachWeb.Router do
  use TeachWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TeachWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", TeachWeb do
    pipe_through :api

    get "/user-details", UserController, :get_user_details
  end
end
