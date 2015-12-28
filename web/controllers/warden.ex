defmodule Forum.Plug.Warden do
  @behavior Plug
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default) do
    default
  end

  def call(conn, _repo) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page!")
      |> redirect(to: Forum.Router.Helpers.user_path(conn, :new))
      |> halt()
    end
  end

end
