defmodule Forum.TopicView do
  use Forum.Web, :view


  def render("index.json", %{topics: topics}) do
    %{topics: render_many(topics, Forum.TopicView, "topic.json")}
  end

  def render("show.json", %{topic: topic}) do
    %{topic: render_one(topic, Forum.TopicView, "topic.json")}
  end

  def render("topic.json", %{topic: topic}) do
    %{id: topic.id,
      title: topic.title,
      subtitle: topic.subtitle,
      posts: fix_json(topic.posts),
      section: topic.section.id,
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
