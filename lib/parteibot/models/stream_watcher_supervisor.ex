defmodule Parteibot.StreamWatcherSupervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    # start a stream StreamWatcher for every hashtag
    # Enum.map(hashtags, fn hashtag -> IO.inspect(hashtag.name) end)
    children = Enum.map(hashtags(), &watcher_for(&1))

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp watcher_for(hashtag) do
    worker(Parteibot.StreamWatcher, [hashtag], id: hashtag.name)
  end

  defp hashtags do
    [
      %Parteibot.Hashtag{name: "apple"},
      %Parteibot.Hashtag{name: "google"}
    ]

    # Parteibot.Repo.all(Parteibot.Hashtag) |> Parteibot.Repo.preload([:twitter_account])
  end
end
