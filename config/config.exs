# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :forum, Forum.Endpoint,
  mailgun_domain: "https://api.mailgun.net/v3/sandbox2b7894ba4a7d4e39a2f3e4092d29501f.mailgun.org",
  mailgun_key: System.get_env("key-220dc162f3e3a4ca9663dd0d32417c1d"),
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "sGB0ZP0fFhx9HqiIHcjb3nLEbGOnqonre7kyJHs/rIpwfFpIAnqicSi33lxm3JKP",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Forum.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :phoenix_token_auth,
  user_model: Forum.User,
  repo: Forum.Repo,
  crypto_provider: Comeonin.Bcrypt,
  token_validity_in_minutes: 7 * 24 * 60,
  email_sender: "djmgguedes@gmail.com",
  emailing_module: Forum.Mailer,
  user_model_validator: {Forum.User, :changeset}

config :joken,
  json_module: PhoenixTokenAuth.PoisonHelper,
  algorithm: :HS256, # Optional. defaults to :HS256,
  secret_key: "very secret test key"
