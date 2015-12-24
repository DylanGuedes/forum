defmodule Forum.PortalController do
  use Forum.Web, :controller

  def index(conn, _params) do
    topics = "1" # to do
    render conn, "index.html", topics: topics 
  end

end
