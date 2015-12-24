defmodule Forum.Section do
  use Forum.Web, :model
  alias Forum.User
  import Ecto.Changeset

  schema "sections" do
    field :name, :string
    field :description, :string
    belongs_to :author, Forum.User
    
    timestamps
  end

end
