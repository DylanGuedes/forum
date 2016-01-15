defmodule Forum.SectionController do
  use Forum.Web, :controller
  alias Forum.Section
  import Ecto.Model
  import Ecto.Query
  alias Forum.Changeset
  alias Forum.Auth
  alias Forum.Topic
  alias Forum.Repo

  def show(conn, %{"id" => id}) do
    section = Repo.get(Forum.Section, id)
    section = Repo.preload section, [:author, :topics]
    topics = from u in Topic, where: u.section_id == ^id, preload: [:author, :posts]
    query = Topic.count_posts(topics)
    topics = Repo.all query
    render conn, "show.html", section: section, topics: topics
  end

  def new(conn, _params) do
    changeset = Ecto.build_assoc(conn.assigns.current_user, :sections_created)
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"section" => section_params }) do
    changeset = Section.changeset(%Section{}, section_params)
    case Repo.insert(changeset) do
      {:ok, section} ->
        conn
        |> put_flash(:info, "Section created!")
        |> redirect(to: portal_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
