defmodule Forum.PortalController do
  use Forum.Web, :controller
  alias Forum.Repo
  alias Forum.Section
  import Ecto.Query

  def index(conn, _params) do
    topics = "1" # to do
    sections = Repo.all from i in Section, preload: [:topics]
    render conn, "index.html", sections: sections
  end

end
