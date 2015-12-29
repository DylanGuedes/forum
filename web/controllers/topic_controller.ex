defmodule Forum.TopicController do
  use Forum.Web, :controller
  alias Forum.User
  alias Forum.Post
  alias Forum.Topic

  import Forum.Plug.Warden

  plug Forum.Plug.Warden

  def show(conn, %{"id" => id}) do
    topic = Repo.get(Forum.Topic, id)
    topic = Repo.preload topic, [:section, :author, :posts]
    posts = Repo.preload topic.posts, [:author]
    render conn, "show.html", topic: topic, posts: posts
  end

  def new(conn, %{"section_id" => section_id}) do
    changeset = Topic.changeset(%Topic{})
    render conn, "new.html", changeset: changeset, section_id: section_id
  end

  def create(conn, %{"topic" => topic_params }) do
    changeset = Topic.changeset(%Topic{}, topic_params)
    case Repo.insert(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic created!")
        |> redirect(to: topic_path(conn, :show, topic.id))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
