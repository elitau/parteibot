# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :parteibot,
  ecto_repos: [Parteibot.Repo]

# Configures the endpoint
config :parteibot, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PoJ4V4LcMVb+wOx0uM41w7QA5rpru9FwRdWUZw00jvCg4e3hGVLuFu2bbf733Pqb",
  render_errors: [view: Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Parteibot.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :hound, driver: "phantomjs"

config :ueberauth, Ueberauth,
  providers: [
    twitter: {Ueberauth.Strategy.Twitter, []}
  ]

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")
