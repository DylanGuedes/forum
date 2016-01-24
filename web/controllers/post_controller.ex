defmodule Forum.PostController do
  use Forum.Web, :controller
  import Ecto.Model
  alias Forum.Repo
  alias Forum.Topic
  alias Forum.Post
  alias Forum.UserController

  import Forum.Plug.Warden

  plug Forum.Plug.Warden when action in [:create]

  def new(conn, %{"topic_id" => topic_id, "content" => quote_content}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Post.changeset(%Post{}, %{content: transform_in_quote(quote_content)})
    render conn, "new.html", changeset: changeset, topic_id: topic_id
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Forum.Post, id)
    post = Repo.preload post, [:topic, :author]
    render conn, "show.json", post: post
  end

  def new(conn, %{"topic_id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset, topic_id: topic_id
  end

  def index(conn, _params) do
    posts = Repo.all from u in Forum.Post, preload: [:topic, :author]
    render conn, "index.json", posts: posts
  end

  defp transform_in_quote(content) do
    """
    <div class="quote">
      #{content}
    </div>

    """
  end

  def create(conn, %{"post" => post_params }) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created!")
        |> redirect(to: topic_path(conn, :show, changeset.changes.topic_id))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
