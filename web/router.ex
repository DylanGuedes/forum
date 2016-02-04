defmodule Forum.Router do
  use Forum.Web, :router
  import PhoenixTokenAuth

  pipeline :authenticated do
    plug PhoenixTokenAuth.Plug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Forum.Auth, repo: Forum.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Forum do
    pipe_through :api

    # PhoenixTokenAuth.mount
    pipe_through :browser # Use the default browser stack
    get "/", PortalController, :index
    resources "/sessions", SessionController, only: [:new, :create]
    #get "/sessions/signout", SessionController, :delete
    resources "/reports", ReportController, only: [:new, :create, :show]
    get "/posts/new", PostController, :new
    get "/admin", AdminController, :index
  end

  scope "/api" do
    pipe_through :api
    PhoenixTokenAuth.mount
  end

  scope "/api" do
    pipe_through :authenticated
    pipe_through :api

    resources "/users", Forum.UserController, only: [:show, :index]
    resources "/sections", Forum.SectionController
    resources "/topics", Forum.TopicController
    resources "/posts", Forum.PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Forum do
  #   pipe_through :api
  # end
end
