defmodule Forum.Repo do
  use Ecto.Repo, otp_app: :forum
  use Scrivener, page_size: 20
end
