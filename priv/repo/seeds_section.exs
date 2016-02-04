import Faker

alias Forum.User
alias Forum.Topic
alias Forum.Section
alias Forum.Post
alias Forum.Changeset
alias Forum.Repo

myrange = 1..50 |> Enum.to_list

for node <- myrange do
  changeset = Section.changeset(%Section{}, %{name: Faker.Name.En.name, author_id: node, description: Faker.Lorem.sentence})
  Repo.insert!(changeset)
end
