defmodule Parteibot do
  # use Application

  def model do
    quote do
      @me __MODULE__

      use Ecto.Schema, warn: false
      import Ecto.Changeset
      import Ecto.Query
      # @primary_key {:id, :string, autogenerate: false}
      # @timestamps_opts [type: :utc_datetime]
      # @foreign_key_type :string
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  # # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # # for more information on OTP Applications
  # def start(_type, _args) do
  #   import Supervisor.Spec
  #   # Define workers and child supervisors to be supervised
  #   children =
  #     [
  #       # Start the Ecto repository
  #       supervisor(Parteibot.Repo, []),
  #       # Start the endpoint when the application starts
  #       supervisor(Web.Endpoint, []),
  #       # Start your own worker by calling: Parteibot.Worker.start_link(arg1, arg2, arg3)
  #       supervisor(Parteibot.StreamWatcherSupervisor, []),
  #     ]

  #   # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
  #   # for other strategies and supported options
  #   opts = [strategy: :one_for_one, name: Parteibot.Supervisor]
  #   Supervisor.start_link(children, opts)
  # end

  # # Tell Phoenix to update the endpoint configuration
  # # whenever the application is updated.
  # def config_change(changed, _new, removed) do
  #   Web.Endpoint.config_change(changed, removed)
  #   :ok
  # end
end
