defmodule Forum.Section do
  use Forum.Web, :model
  alias Forum.User
  alias Forum.Topic
  import Ecto.Changeset

  schema "sections" do
    field :name
    field :description
    belongs_to :author, Forum.User
    has_many :topics, Forum.Topic
    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(author_id topic_id content), [] )
    |> validate_length(:content, min: 10, max: 99999)
  end

end
