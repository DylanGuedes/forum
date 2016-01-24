defmodule Forum.SectionView do
  use Forum.Web, :view

  def render("index.json", %{sections: sections}) do
    %{sections: render_many(sections, Forum.SectionView, "section.json")}
  end

  def render("show.json", %{section: section}) do
    %{section: render_one(section, Forum.SectionView, "section.json")}
  end

  def render("section.json", %{section: section}) do
    %{id: section.id,
      name: section.name,
      description: section.description,
      mytopics: inject_topics(section.topics)
    }
  end

  def inject_topics([]) do
    []
  end

  def inject_topics(topics) do
    for topic <- topics do
      topic.id
    end
  end

end
