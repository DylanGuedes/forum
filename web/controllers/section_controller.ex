defmodule Forum.SectionController do
  use Forum.Web, :controller
  alias Forum.Section
  import Ecto.Model
  import Ecto.Query
  alias Forum.Changeset
  alias Forum.Auth
  alias Forum.Topic
  alias Forum.Repo

  plug :scrub_params, "section" when action in [:create, :update]

  def show(conn, %{"id" => id}) do
    section = Repo.get!(Section, id)
    section = Repo.preload section, [:topics, :author]
    render(conn, "show.json", section: section)
  end

  def new(conn, _params) do
    changeset = Ecto.build_assoc(conn.assigns.current_user, :sections_created)
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"section" => section_params}) do
    changeset = Section.changeset(%Section{}, section_params)
    case Repo.insert(changeset) do
      {:ok, section} ->
        section = Repo.preload section, [:topics, :author]

        conn
        |> put_status(:created)
        |> put_resp_header("location", section_path(conn, :show, section))
        |> render("show.json", section: section)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Forum.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def index(conn, _params) do
    sections = Repo.all from u in Section, preload: [:topics, :author]
    render(conn, "index.json", sections: sections)
  end

end
