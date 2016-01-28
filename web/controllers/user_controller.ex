defmodule Forum.UserController do
  use Forum.Web, :controller
  alias Forum.User
  plug :authenticate when action in [:show, :index]

  def index(conn, _params) do
    users = Repo.all from u in Forum.User, preload: [:topics_created, :posts_created, :sections_created]
    render conn, "index.json", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(Forum.User, id)
    user = Repo.preload user, [:posts_created, :topics_created, :sections_created]
    render conn, "show.json", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params }) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Forum.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp authenticate(conn, _) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page!")
      |> redirect(to: user_path(conn, :index))
      |> halt()
    end
  end
end
