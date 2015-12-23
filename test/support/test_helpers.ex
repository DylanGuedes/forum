defmodule Forum.TestHelpers do
  alias Forum.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Some User",
      username: "user#{Base.encode16(:crypto.rand_bytes(8))}",
      password: "supersecret",
    }, attrs)

    %Forum.User{}
    |> Forum.User.registration_changeset(changes)
    |> Repo.insert!()
  end
end
