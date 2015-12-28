defmodule Forum.Post do
  use Forum.Web, :model
  alias Forum.User
  alias Forum.Topic
  import Ecto.Changeset

  schema "posts" do
    belongs_to :topic, Forum.Topic
    belongs_to :author, Forum.User
    field :content
    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(author_id topic_id content), [])
    |> validate_length(:content, min: 10, max: 99999)
  end

end
