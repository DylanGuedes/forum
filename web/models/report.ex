defmodule Forum.Report do
  use Forum.Web, :model

  import Ecto.Query
  alias Forum.Repo

  schema "reports" do
    field :title
    field :content
    belongs_to :author, Forum.User
    belongs_to :target, Forum.User
    field :pending
    field :accepted
    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(author_id target_id content title), ~w(pending))
    |> validate_length(:content, min: 10, max: 99999)
    |> validate_length(:title, min: 3, max: 150)
  end

  def pendings do
    from u in Forum.Report, where: u.pending == :true
  end

end
