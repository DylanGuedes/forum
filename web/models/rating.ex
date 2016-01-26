defmodule Forum.Rating do
  use Forum.Web, :model
  alias Forum.User
  alias Forum.Topic
  import Ecto.Changeset

  schema "ratings" do
    belongs_to :post, Forum.Post
    belongs_to :user, Forum.User

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(post_id user_id), [])
  end

end
