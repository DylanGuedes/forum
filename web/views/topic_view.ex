defmodule Forum.TopicView do
  use Forum.Web, :view


  def render("index.json", %{topics: topics, page_number: page_number, page_size: page_size, total_pages: total_pages, total_entries: total_entries}) do
    %{
      topics: render_many(topics, Forum.TopicView, "topic.json"),
      meta: %{
        page_number: page_number,
        page_size: page_size,
        total_entries: total_entries,
        total_pages: total_pages
      }
    }
  end

  def render("show.json", %{topic: topic}) do
    %{topic: render_one(topic, Forum.TopicView, "topic.json")}
  end

  def render("topic.json", %{topic: topic}) do
    %{id: topic.id,
      title: topic.title,
      subtitle: topic.subtitle,
      posts: fix_json(topic.posts),
      section: topic.section_id,
      content: topic.content,
      author: topic.author_id,
      created_at: topic.inserted_at
    }
  end

  def fix_json([]) do
    []
  end

  def fix_json(entity) do
    for node <- entity do
      node.id
    end
  end

end
