defmodule Parteibot.MixProject do
  use Mix.Project

  def project do
    [
      app: :parteibot,
      version: "0.0.1",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      name: "Parteibot"
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Parteibot.Application, []},
      extra_applications: [:logger, :runtime_tools, :extwitter, :ueberauth_twitter]
      # applications: [
      #   :phoenix,
      #   :phoenix_pubsub,
      #   :phoenix_html,
      #   :cowboy,
      #   :logger,
      #   :gettext,
      #   :phoenix_ecto,
      #   :postgrex,
      #   :extwitter,
      #   :oauth,
      #   :ueberauth,
      #   :ueberauth_twitter,
      #   :rollbax
      # ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.1"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      # A static code analysis tool for the Elixir language with a focus on code consistency and teaching.
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:hound, "~> 1.0"},
      {:rollbax, "~> 0.10"},
      {:oauther, "~> 1.1"},
      {:extwitter, "~> 0.8"},
      # {:oauth, github: "tim/erlang-oauth"},
      {:ueberauth, "~> 0.5"},
      {:ueberauth_twitter, "~> 0.2"},
      {:plug_cowboy, "~> 2.0"},
      {:distillery, "~> 1.5.5"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
