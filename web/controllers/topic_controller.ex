defmodule Forum.TopicController do
  use Forum.Web, :controller
  alias Forum.User
  alias Forum.Post
  alias Forum.Topic

  def show(conn, %{"id" => id}) do
    topic = Repo.get(Forum.Topic, id)
    topic = Repo.preload topic, [:section, :author, :posts]
    posts = Repo.preload topic.posts, [:author]
    render conn, "show.html", topic: topic, posts: posts
  end

  def new_post(conn, %{"topic_id" => topic_id}) do
    topic = Repo.get(Forum.Topic, topic_id)
    changeset = Ecto.build_assoc(topic, :posts)
    render conn, "new_post.html", changeset: changeset
  end

  def create_post(conn, %{"post_params" => post_params}) do
    render conn, "show.html", id: post_params.id
  end

end
