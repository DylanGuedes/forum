# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Forum.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Faker
alias Forum.User
alias Forum.Topic
alias Forum.Section
alias Forum.Post
alias Forum.Changeset

myrange = 1..100 |> Enum.to_list

for node <- myrange do
  changeset = User.changeset(%User{}, %{username: Faker.Name.En.name, name: Faker.Name.first_name, email: Faker.Internet.email, password: "teste123"})
  Forum.Repo.insert!(changeset)
end

for leaf <- myrange do
  for node <- myrange do
    changeset = Topic.changeset(%Topic{}, %{title: Faker.Lorem.sentence, content: Faker.Lorem.paragraph, subtitle: Faker.Lorem.sentence, author_id: node, section_id: 2 })
    Forum.Repo.insert!(changeset)
  end
end

for leaf <- myrange do
  for node <- myrange do
    changeset = Post.changeset(%Post{}, %{content: Faker.Lorem.paragraph, topic_id: node, author_id: leaf})
    Forum.Repo.insert!(changeset)
  end
end


