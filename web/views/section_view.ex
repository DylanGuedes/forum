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
      topics: ember_parser(section.topics),
      author: section.author_id,
      created_at: section.inserted_at
    }
  end

  def ember_parser([]) do
    []
  end

  def ember_parser(topics) do
    for topic <- topics do
      topic.id
    end
  end

end
