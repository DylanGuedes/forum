defmodule Forum.SectionController do
  use Forum.Web, :controller
  alias Forum.Section
  import Ecto.Model
  import Ecto.Query
  alias Forum.Changeset
  alias Forum.Auth

  def show(conn, %{"id" => id}) do
    section = Repo.get(Forum.Section, id)
    section = Repo.preload section, [:author, :topics]
    topics = Repo.preload section.topics, [:author]
    render conn, "show.html", section: section, topics: topics
  end

  def new(conn, _params) do
    changeset = Ecto.build_assoc(conn.assigns.current_user, :sections_created)
    render conn, "new.html", changeset: changeset
  end

end
