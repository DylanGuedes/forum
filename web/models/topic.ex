defmodule Forum.Topic do
  use Forum.Web, :model
  import Ecto.Changeset
  alias Forum.Section
  alias Forum.User
  alias Forum.Post

  schema "topics" do
    field :title
    field :subtitle
    belongs_to :author, Forum.User
    belongs_to :section, Forum.Section
    field :content
    has_many :posts, Forum.Post
    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(author_id section_id content title), ~w(subtitle) )
    |> validate_length(:content, min: 10, max: 99999)
    |> validate_length(:title, min: 3, max: 150)
    |> validate_length(:subtitle, min: 3, max: 150)
  end

end
