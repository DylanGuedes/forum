defmodule Forum.User do
  use Forum.Web, :model
  alias Forum.Section
  alias Forum.Topic
  alias Forum.Post
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :admin, :boolean
    field :email, :string
    has_many :sections_created, Forum.Section, foreign_key: :author_id
    has_many :topics_created, Forum.Topic, foreign_key: :author_id
    has_many :posts_created, Forum.Post, foreign_key: :author_id
    field  :hashed_password, :string
    field  :hashed_confirmation_token, :string
    field  :confirmed_at, Ecto.DateTime
    field  :hashed_password_reset_token, :string
    field  :unconfirmed_email, :string
    field  :authentication_tokens, {:array, :string}, default: []
    timestamps
  end

  def change_admin(model, params \\ :empty) do
    model
    |> cast(params, ~w(admin), [])
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(username), ~w(name))
  end

  def registration_changeset(model, params \\ :empty) do
    IO.puts("JSON AQUI")
    IO.inspect(model)
    model
    #|> changeset(params)
    #|> cast(params, ~w(password), [])
    #|> validate_length(:password, min: 6, max: 100)
    #  |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
