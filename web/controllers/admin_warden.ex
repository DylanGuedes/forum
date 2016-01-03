defmodule Forum.Plug.AdminWarden do
  @behavior Plug
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default) do
    default
  end

  def call(conn, _repo) do
    if conn.assigns.current_user && conn.assigns.current_user.admin do
      conn
    else
      conn
      |> put_flash(:error, "You don't have enough permission!")
      |> redirect(to: Forum.Router.Helpers.portal_path(conn, :index))
    end
  end
end
