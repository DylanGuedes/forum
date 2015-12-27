defmodule Forum.PostController do
  use Forum.Web, :controller
  import Ecto.Model
  alias Forum.Repo
  alias Forum.Topic

  def new(conn, %{"topic_id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = 
    changeset = Repo.preload changeset, [:author, :topic]
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"post" => post_params }) do
    case Repo.insert(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "User created!")
        |> redirect(to: user_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


end
