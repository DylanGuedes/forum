defmodule Forum.SessionController do
  use Forum.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Forum.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: user_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong combination!")
        |> render("new.html")
    end
  end 
end
