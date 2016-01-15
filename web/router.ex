defmodule Forum.Router do
  use Forum.Web, :router

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
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController, only: [:index, :new, :create, :show]
    get "/", PortalController, :index
    resources "/sessions", SessionController, only: [:new, :create]
    get "/sessions/signout", SessionController, :delete
    resources "/sections", SectionController, only: [:show, :new, :create]
    resources "/topics", TopicController, only: [:show, :new, :create]
    resources "/posts", PostController, only: [:new, :create]
    resources "/reports", ReportController, only: [:new, :create, :show]
    get "/posts/new", PostController, :new
    get "/admin", AdminController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Forum do
  #   pipe_through :api
  # end
end
