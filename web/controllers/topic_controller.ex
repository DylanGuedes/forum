defmodule Forum.TopicController do
  use Forum.Web, :controller
  alias Forum.User
  alias Forum.Post
  alias Forum.Topic

  import Forum.Plug.Warden

  plug Forum.Plug.Warden when action in [:new, :create]

  plug :scrub_params, "section" when action in [:create, :update]

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

  #def create(conn, %{"topic" => topic_params }) do
    # changeset = Topic.changeset(%Topic{}, topic_params)
    #case Repo.insert(changeset) do
      #{:ok, topic} ->
        #conn
        #|> put_flash(:info, "Topic created!")
        # |> redirect(to: topic_path(conn, :show, topic.id))

      #{:error, changeset} ->
        #render(conn, "new.html", changeset: changeset)
        #end
    #end

  def create(conn, %{"topic" => topic_params }) do
    changeset = Topic.changeset(%Topic{}, topic_params)
    case Repo.insert(changeset) do
      {:ok, topic} ->
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

  def index(conn, _params) do
    topics = Repo.all from u in Topic, preload: [:section, :author, :posts]
    render(conn, "index.json", topics: topics)
  end

end
