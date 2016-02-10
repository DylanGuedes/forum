defmodule Forum.Message do
  use Forum.Web, :model
  import Ecto.Changeset

  schema "messages" do
    belongs_to :target, Forum.User
    belongs_to :source, Forum.User
    field :content
    timestamps
  end

  @required_fields ~w(target_id source_id content)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
