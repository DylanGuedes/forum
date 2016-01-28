defmodule Forum.Section do
  use Forum.Web, :model
  alias Forum.User
  alias Forum.Repo
  alias Forum.Topic
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id]}

  schema "sections" do
    field :name
    field :description
    belongs_to :author, Forum.User
    has_many :topics, Forum.Topic
    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(author_id description name), [] )
    |> unique_constraint(:name)
    |> validate_length(:description, min: 10, max: 99999)
    |> validate_length(:name, min: 3, max: 100)
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
    if List.last(result) do
      mylist = for topic <- result do
        Forum.Topic.posts_amount(topic.id)
      end
      Enum.sum(List.flatten(mylist))
    end
  end

  def last_topic(section_id) do
    query = from p in Topic, where: p.section_id == ^section_id, preload: [:author, :posts], order_by: [desc: p.inserted_at]
    topics = Repo.all query
    topic = hd(topics)
  end

end
