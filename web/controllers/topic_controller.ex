defmodule Forum.TopicController do
  use Forum.Web, :controller
  alias Forum.Repo
  alias Forum.User
  alias Forum.Post
  alias Forum.Topic

  import Ecto.Query

  plug :scrub_params, "topic" when action in [:create, :update]

  def show(conn, %{"id" => id}) do
    topic = Repo.get!(Topic, id)
    topic = Repo.preload topic, [:author, :posts, :section]
    render(conn, "show.json", topic: topic)
  end

  #  def show(conn, %{"id" => id}) do
    # topic = Repo.get(Forum.Topic, id)
    #topic = Repo.preload topic, [:section, :author, :posts]
    #posts = Repo.preload topic.posts, [:author]
    #render conn, "show.html", topic: topic, posts: posts
    # end

  def new(conn, %{"section_id" => section_id}) do
    changeset = Topic.changeset(%Topic{})
    render conn, "new.html", changeset: changeset, section_id: section_id
  end

  def create(conn, %{"topic" => topic_params }) do
    changeset = Topic.changeset(%Topic{}, topic_params)
    case Repo.insert(changeset) do
      {:ok, topic} ->
        topic = Repo.preload topic, [:author, :section, :posts]
        conn
        |> put_status(:created)
        |> put_resp_header("location", topic_path(conn, :show, topic))
        |> render("show.json", topic: topic)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Forum.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def index(conn, params) do
    if(params["section_id"]) do
      topics = Topic
      |> where([p], p.section_id == ^params["section_id"])
      |> order_by([p], desc: p.inserted_at)
      |> preload(:posts)
      |> Repo.paginate(page: params["page"])
    else
      topics = Topic
      |> order_by([p], desc: p.inserted_at)
      |> preload(:posts)
      |> Repo.paginate(page: params["page"])
    end

    render conn, "index.json",
    topics: topics.entries,
    page_number: topics.page_number,
    page_size: topics.page_size,
    total_pages: topics.total_pages,
    total_entries: topics.total_entries
  end

end
