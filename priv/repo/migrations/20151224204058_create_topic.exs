defmodule Forum.Repo.Migrations.CreateTopic do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :subtitle, :string
      add :author_id, references(:users)
      add :section_id, references(:sections)
      add :content, :text

      timestamps
    end

    create index(:topics, [:author_id, :section_id])
  end
end
