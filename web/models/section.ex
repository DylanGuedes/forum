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

  def count_topics(query) do
    from p in query,
      group_by: p.id,
      left_join: c in assoc(p, :topics),
      select: {p, count(c.id)}
  end

  def count_posts(section_id) do
    total_posts = 0
    topics = from u in Topic, preload: [:section, :posts], where: u.section_id == ^section_id
    result = Repo.all topics
    for topic <- result do
      total_posts = total_posts + Forum.Topic.posts_amount(topic.id)
    end
    total_posts
  end

end
