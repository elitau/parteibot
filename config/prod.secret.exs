use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :parteibot, Parteibot.Endpoint,
  secret_key_base: "RREc78cAFcXQQsL8MMpCohm1Uy3Cvje5+i00fpUxAb5vVNtPMdMOZPXHTOGPOJqh"

# Configure your database
config :parteibot, Parteibot.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "parteibot_prod",
  pool_size: 20
