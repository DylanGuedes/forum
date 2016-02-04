defmodule Forum.PostView do
  use Forum.Web, :view

  def render("index.json", %{posts: posts, total_pages: total_pages, total_entries: total_entries, page_number: page_number, page_size: page_size}) do
    %{
      posts: render_many(posts, Forum.PostView, "post.json"),
      meta: %{
        page_size: page_size,
        page_number: page_number,
        total_entries: total_entries,
        total_pages: total_pages
      }
    }
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

end
