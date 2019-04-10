defmodule Parteibot.Repo do
  use Ecto.Repo,
    otp_app: :parteibot,
    adapter: Ecto.Adapters.Postgres
end
