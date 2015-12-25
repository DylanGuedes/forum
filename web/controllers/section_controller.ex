defmodule Forum.SectionController do
  use Forum.Web, :controller
  alias Forum.Section

  def show(conn, %{"id" => id}) do
    section = Repo.get(Forum.Section, id)
    section = Repo.preload section, [:author, :topics]
    topics = Repo.preload section.topics, [:author]
    render conn, "show.html", section: section, topics: topics
  end

end
