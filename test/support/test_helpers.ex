defmodule Forum.TestHelpers do
  alias Forum.Repo

  def insert_user(attrs \\ %{}) do
    changes = %{
      name: "Some User",
      username: "areallyniceuser",
      password: "supersecret",
    }

    %Forum.User{}
    |> Forum.User.changeset(changes)
    |> Repo.insert()
  end
end
