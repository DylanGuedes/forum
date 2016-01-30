defmodule Forum.UserView do
  use Forum.Web, :view
  alias Forum.User

  def abstract(text) do
    {string_abstract, garbage} = String.split_at(text, 70)
    string_abstract
  end

  def render("index.json", %{users: users}) do
    %{users: render_many(users, Forum.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, Forum.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      username: user.username,
      admin: user.admin,
      sections_created: fix_json(user.sections_created),
      topics_created: fix_json(user.topics_created),
      posts_created: fix_json(user.posts_created),
      email: user.email,
      created_at: user.inserted_at
    }
  end

  def fix_json(entity) do
    for node <- entity do
      node.id
    end
  end

end
