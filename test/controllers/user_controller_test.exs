defmodule Forum.UserControllerTest do
  import Plug.Conn
  use Forum.ConnCase
  alias Forum.User
  import Forum.Auth

  setup do
    user = insert_user(username: "teste123")
    conn = assign(conn(), :current_user, user)
    {:ok, conn: conn, user: user}
  end

  test "users#index should return success" do
    conn = get conn(), user_path(conn, :index)
    assert html_response(conn, 200)
  end

  test "users#new should return success" do
    conn = get conn(), user_path(conn, :new)
    assert html_response(conn, 200)
  end

  test "users#show should redirect if not logged in" do
    myuser = %User{name: "teste123", username: "mytest123", password: "othertest123"}
    {:ok, user_hash} = Repo.insert(myuser)
    conn = get conn(), user_path(conn, :show, user_hash.id)
    assert html_response(conn, 302)
  end

  test "users#show should return success if user is logged", %{conn: conn, user: user} do
    conn = get conn, user_path(conn, :show, user.id)
    assert html_response(conn, 303)
  end

  test "requires user authentication in some actions", %{conn: conn} do
    Enum.each([
      get(conn, user_path(conn, :show, "123")),
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end
end
