defmodule Parteibot.StreamWatcher do
  use GenServer
  require Logger
  defstruct hashtag: nil, twitter_stream: nil

  def start_link(hashtag) do
    GenServer.start_link(__MODULE__, hashtag)
  end

  def init(state) do
    config_extwitter()
    send(self(), :start_streaming)
    {:ok, state}
  end

  def handle_info(:start_streaming, state) do
    spawn_link fn ->
      hashtag = state
      twitter_stream = ExTwitter.stream_filter([track: hashtag], :infinity)
      |> Stream.filter(fn tweet -> handle_hashtag_mention(tweet, hashtag) end)
      Enum.to_list(twitter_stream)
    end
    {:noreply, state}
  end

  defp handle_hashtag_mention(tweet, hashtag) do
    # Parteibot.Responder.send_reply(tweet, hashtag)
    # IO.inspect(hashtag)
    # IO.inspect(tweet.text)
    Logger.info("Hashtag '#{hashtag}' mentionend in '#{tweet.text}'")
    tweet
  end

  defp config_extwitter do
    ExTwitter.configure(
       consumer_key: "QZhARwLdNDOLLMLwtkpWa5RxX",
       consumer_secret: "Vg5VTzqVS8qiy1S6SRg0ZxLhXtdGkH3JQcyUz28vJGrumext9j",
       access_token: "121459971-PvfK40YY7OGscGD9QYW5QB4y6WatBrLRHD7LkF1o",
       access_token_secret: "XOAkc2gNMo6PtmlplfDSOE3TU1sdUqdG7redJbswI5JbA"
    )
  end
end