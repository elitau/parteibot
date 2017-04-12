defmodule Parteibot.StreamWatcherSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    # start a stream StreamWatcher for every hashtag
    # Enum.map(hashtags, fn hashtag -> IO.inspect(hashtag.name) end)
    children = Enum.map(hashtags(), &(watcher_for(&1)))

    supervise(children, strategy: :one_for_one)
  end

  defp watcher_for(hashtag) do
    worker(Parteibot.StreamWatcher, [hashtag], [id: hashtag.name])
  end

  defp hashtags do
    Parteibot.Repo.all(Parteibot.Hashtag) |> Parteibot.Repo.preload([:twitter_account])
  end
end