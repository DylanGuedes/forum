defmodule Forum.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :user_id, references(:users)
      add :post_id, references(:posts)

      timestamps
    end

    create index(:ratings, [:user_id, :post_id])
  end

end
