defmodule Forum.UserController do
  use Forum.Web, :controller
  alias Forum.User
  alias Forum.Repo
  import Ecto.Query

  def index(conn, params) do
    users = User
    |> order_by([p], desc: p.inserted_at)
    |> Repo.paginate(page: params["page"])

    render conn, "index.json",
    users: users.entries,
    page_number: users.page_number,
    page_size: users.page_size,
    total_pages: users.total_pages,
    total_entries: users.total_entries
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
