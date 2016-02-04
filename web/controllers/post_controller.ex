defmodule Forum.PostController do
  use Forum.Web, :controller
  import Ecto.Model
  import Ecto.Query
  alias Forum.Repo
  alias Forum.Topic
  alias Forum.Post
  alias Forum.UserController

  @derive {Poison.Encoder, only: [:id]}

  def new(conn, %{"topic_id" => topic_id, "content" => quote_content}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Post.changeset(%Post{}, %{content: transform_in_quote(quote_content)})
    render conn, "new.html", changeset: changeset, topic_id: topic_id
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Forum.Post, id)
    render conn, "show.json", post: post
  end

  def new(conn, %{"topic_id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset, topic_id: topic_id
  end

  def index(conn, params) do
    if(params["topic_id"]) do
      posts = Post
      |> where([p], p.topic_id == ^params["topic_id"])
      |> order_by([p], asc: p.inserted_at)
      |> Repo.paginate(page: params["page"])
    else
      posts = Post
      |> order_by([p], desc: p.inserted_at)
      |> Repo.paginate(page: params["page"])
    end

    render conn, "index.json",
    posts: posts.entries,
    page_number: posts.page_number,
    page_size: posts.page_size,
    total_pages: posts.total_pages,
    total_entries: posts.total_entries
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
        |> put_status(:created)
        |> put_resp_header("location", post_path(conn, :show, post))
        |> render("show.json", post: post)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Forum.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        render(conn, "show.json", post: post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Forum.ChangesetView, "error.json", changeset: changeset)
    end
  end

end
