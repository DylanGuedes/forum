defmodule Forum.PortalController do
  use Forum.Web, :controller
  alias Forum.Repo
  alias Forum.Section
  import Ecto.Query

  def index(conn, _params) do
    render conn, "index.html"
  end

end
