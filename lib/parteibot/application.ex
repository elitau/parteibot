defmodule Parteibot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Parteibot.Repo,
      # Start the endpoint when the application starts
      Web.Endpoint,
      Parteibot.Supervisor
      # Starts a worker by calling: Parteibot.Worker.start_link(arg)
      # {Parteibot.Worker, arg},
    ]

    # ++ environment_specific_children(Mix.env())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Parteibot.ApplicationSupervisor]
    Supervisor.start_link(children, opts)
  end

  # defp environment_specific_children(:test), do: []
  # defp environment_specific_children(_), do: [Parteibot.Supervisor]

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
