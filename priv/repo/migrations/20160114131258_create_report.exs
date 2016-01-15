defmodule Forum.Repo.Migrations.CreateReport do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :title, :string
      add :content, :text
      add :author_id, references(:users)
      add :target_id, references(:users)
      add :pending, :boolean, default: :true
      add :accepted, :boolean

      timestamps
    end

    create index(:reports, [:author_id, :target_id])
  end
end
