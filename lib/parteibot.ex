defmodule Parteibot do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec
    children =
      [
        # Start the Ecto repository
        supervisor(Parteibot.Repo, []),
        # Start the endpoint when the application starts
        supervisor(Parteibot.Endpoint, []),
        # Start your own worker by calling: Parteibot.Worker.start_link(arg1, arg2, arg3)
        worker(Parteibot.TwitterStreamWorker, []),
      ]
    # else
    #   [
    #     # Start the Ecto repository
    #     supervisor(Parteibot.Repo, []),
    #     # Start the endpoint when the application starts
    #     supervisor(Parteibot.Endpoint, []),
    #     # Start your own worker by calling: Parteibot.Worker.start_link(arg1, arg2, arg3)
    #     # worker(Parteibot.TwitterStreamWorker, []),
    #   ]
    # end
    # Define workers and child supervisors to be supervised


    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Parteibot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Parteibot.Endpoint.config_change(changed, removed)
    :ok
  end
end
