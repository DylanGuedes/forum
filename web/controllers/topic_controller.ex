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

end
