defmodule Forum.Repo.Migrations.CreateSection do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add :name, :string
      add :description, :string
      add :author_id, references(:users)

      timestamps
    end

    create index(:sections, [:author_id])
  end
end
