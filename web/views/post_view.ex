defmodule Forum.PostView do
  use Forum.Web, :view

  def render("index.json", %{posts: posts}) do
    %{posts: render_many(posts, Forum.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{post: render_one(post, Forum.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      topic: post.topic_id,
      author: post.author_id,
      content: post.content,
      created_at: post.inserted_at
    }
  end

  def fix_json(entity) do
    for node <- entity do
      node.id
    end
  end

end
