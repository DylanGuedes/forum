defmodule Forum.SessionControllerTest do
  import Plug.Conn
  use Forum.ConnCase
  alias Forum.User

  setup do
    user = insert_user(username: "teste123")
    conn = assign(conn(), :current_user, user)
      {:ok, conn: conn, user: user}
  end

  test "sessions#new should work" do
    conn = get conn(), session_path(conn, :new)
    assert html_response(conn, 200)
  end

  test "sessions#create with valid params should create a user" do
    conn = post conn(), session_path(conn, :create, %{"session" => %{"username" => "test123", "password" => "test123"} })
    assert html_response(conn, 200)
    list = Repo.all User
    assert List.last(list).username, "test123"
  end

end
