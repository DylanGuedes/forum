defmodule Forum.PortalController do
  use Forum.Web, :controller
  alias Forum.Repo
  alias Forum.Section
  import Ecto.Query

  def index(conn, _params) do
    sections = from u in Section, preload: [:topics, :author]
    query = Section.count_topics(sections)
    sections = Repo.all query
    render conn, "index.html", sections: sections
  end

end
