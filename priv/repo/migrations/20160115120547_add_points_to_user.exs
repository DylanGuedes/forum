defmodule Forum.Repo.Migrations.AddPointsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :points, :integer
    end
  end
end
