defmodule Forum.Topic do
  use Forum.Web, :model
  import Ecto.Changeset
  alias Forum.Section
  alias Forum.User
  alias Forum.Post
  alias Forum.Repo
  import Ecto.Query

  @derive {Poison.Encoder, only: [:id]}

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

  def count_posts(query) do
    from p in query,
      group_by: p.id,
      left_join: c in assoc(p, :posts),
      select: {p, count(c.id)}
  end

  def posts_amount(id) do
    total_posts = 0
    posts = from p in Post, where: p.topic_id == ^id, select: count(p.id), group_by: p.id
    posts = Repo.all posts
  end

  def last_post(topic) do
    post = List.last(topic.posts)
    if post do
      post = Repo.preload post, [:author]
    end
  end

end
