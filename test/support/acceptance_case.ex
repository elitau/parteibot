defmodule Parteibot.AcceptanceCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import Ecto.Query, only: [from: 2]
      import Web.Router.Helpers

      alias Parteibot.Repo

      # The default endpoint for testing
      @endpoint Web.Endpoint

      hound_session()
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Parteibot.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Parteibot.Repo, {:shared, self()})
    end

    :ok
  end
end
