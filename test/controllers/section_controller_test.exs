defmodule Forum.SectionControllerTest do
  import Plug.Conn
  use Forum.ConnCase
  alias Forum.User
  alias Forum.Section
  import Forum.Auth

  test "sections#index should redirect if not logged in" do
    conn = get conn(), section_path(conn, :index)
    assert response(conn, 401)
  end

  test "sections#show should redirect if not logged in" do
    {:ok, user} = insert_user(username: "teste123")
    mysection = %Section{name: "Areallynicesection", author_id: user.id, description: "easily the best section evah"}
    {:ok, section_hash} = Repo.insert(mysection)

    conn = get conn(), section_path(conn, :show, section_hash.id)
    assert response(conn, 401)
  end

  test "show and index should show cintent if the user is authenticated" do
    {:ok, user} = insert_user(username: "teste123")
    conn = put_req_header(conn(), "authorization", "Bearer teste123")
    mysection = %Section{name: "Areallynicesection", author_id: user.id, description: "easily the best section evah"}
    {:ok, section_hash} = Repo.insert(mysection)

    conn = get conn(), section_path(conn, :show, section_hash.id)
    assert json_response(conn, 200)
  end

end
