defmodule Forum.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string
      add :target_id, references(:users)
      add :source_id, references(:users)

      timestamps
    end

    create index(:messages, [:source_id, :target_id])
  end
end
