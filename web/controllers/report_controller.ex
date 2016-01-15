defmodule Forum.ReportController do
  use Forum.Web, :controller

  alias Forum.Report
  alias Forum.User
  import Forum.Plug.Warden

  plug Forum.Plug.Warden

  def new(conn, %{"target_id" => target_id}) do
    changeset = Report.changeset(%Report{}, %{"target_id" => target_id, "author_id" => conn.assigns.current_user.id})
    target = Repo.get(User, target_id)
    render conn, "new.html", changeset: changeset, target: target
  end

  def create(conn, %{"report" => report_params}) do
    pending_status = %{"pending" => "true"}
    changeset = Report.changeset(%Report{}, Map.merge(report_params, pending_status))
    case Repo.insert(changeset) do
      {:ok, report} ->
        conn
        |> put_flash(:info, "Report created!")
        |> redirect(to: user_path(conn, :show, changeset.changes.target_id))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
