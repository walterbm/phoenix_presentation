defmodule PhoenixPresentation.Web.Router do
  use PhoenixPresentation.Web, :router

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

  scope "/", PhoenixPresentation.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/chat", ChatController, :index
    get "/presentation", PresentationController, :index
    get "/presentation/:slide", PresentationController, :index
    get "/math", MathController, :index
    post "/math", MathController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixPresentation.Web do
  #   pipe_through :api
  # end
end
