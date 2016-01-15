defmodule Forum.AdminController do
  use Forum.Web, :controller
  alias Forum.Section
  import Forum.Plug.Warden
  import Forum.Plug.AdminWarden

  plug Forum.Plug.Warden
  plug Forum.Plug.AdminWarden


  def index(conn, _) do
    changeset = Forum.Section.changeset(%Section{})
    render conn, "index.html", changeset: changeset
  end

end
