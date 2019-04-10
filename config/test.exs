use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :parteibot, Web.Endpoint,
  http: [port: 4001],
  server: true

config :parteibot, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :parteibot, Parteibot.Repo,
  username: "admin1",
  password: "admin1",
  database: "parteibot_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :rollbax, enabled: false
