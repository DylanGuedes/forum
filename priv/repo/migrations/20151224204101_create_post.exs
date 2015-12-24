defmodule Forum.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :author_id, references(:users)
      add :topic_id, references(:topics)
      add :content, :text

      timestamps
    end

    create index(:posts, [:author_id, :topic_id])
  end
end
