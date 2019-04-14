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
      %Parteibot.Hashtag{
        name: "erlang",
        reply_messages: [
          %Parteibot.ReplyMessage{content: "Seems right."},
          %Parteibot.ReplyMessage{content: "Thats cool."},
          %Parteibot.ReplyMessage{content: "Oh no."},
          %Parteibot.ReplyMessage{content: "Oh yes."},
          %Parteibot.ReplyMessage{content: "Yess, erlang!."},
          %Parteibot.ReplyMessage{content: "Just the best"},
          %Parteibot.ReplyMessage{content: "Thank you."}
        ]
      },
      %Parteibot.Hashtag{
        name: "#cologne",
        reply_messages: [
          %Parteibot.ReplyMessage{content: "Yeah. Köln!"},
          %Parteibot.ReplyMessage{content: "Cologne is the best."},
          %Parteibot.ReplyMessage{content: "Just cool"},
          %Parteibot.ReplyMessage{content: "So nice."},
          %Parteibot.ReplyMessage{content: "I like it"},
          %Parteibot.ReplyMessage{content: "Stimmt, seh ich auch so."},
          %Parteibot.ReplyMessage{content: "Warum auch nicht?"}
        ]
      }
    ]

    # Parteibot.Repo.all(Parteibot.Hashtag) |> Parteibot.Repo.preload([:twitter_account])
  end
end
