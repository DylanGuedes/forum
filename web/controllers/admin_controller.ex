defmodule Forum.AdminController do
  use Forum.Web, :controller
  import Forum.Plug.Warden
  import Forum.Plug.AdminWarden

  plug Forum.Plug.Warden
  plug Forum.Plug.AdminWarden


  def index(conn, _) do
    render conn, "index.html"
  end

end
