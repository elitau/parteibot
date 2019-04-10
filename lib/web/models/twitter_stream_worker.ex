defmodule Parteibot.TwitterStreamWorker do
  use GenServer

  @moduledoc """
  Listens to twitter streams
  """
  ## Client API

  @doc """
  Starts the worker registry.
  """
  def start_link(_args \\ nil) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  ## Server Callbacks

  # Receives the :ok argument given to start_link.
  def init(:ok) do
    config_extwitter()
    pid = start_stream()
    {:ok, pid}
  end

  defp start_stream do
    # hashtags = Parteibot.Repo.all(Parteibot.Hashtag)
    # IO.puts "Spawning stream watch process for #{Enum.map(hashtags, &(&1.name))}"
    #   |> Stream.map(fn(x) -> x.text end)
    #   |> Stream.map(fn(x) -> IO.puts "#{x}\n---------------\n" end)
    # Enum.to_list(stream)
    [p1 | [p2 | [p3 | tail]]] =
      Enum.map(["#apple", "#google", "#sony"], fn htag -> start_stream_for(htag) end)

    # head
    # start_stream_for(p2)
    # p2
    IO.inspect(p1)
    IO.inspect(p2)
    IO.inspect(p3)
    IO.puts("_tail #{tail}")
    p2
  end

  def start_stream_for(hashtag) do
    IO.puts("Spawning stream watch process for #{hashtag}")
    stream = ExTwitter.stream_filter(track: hashtag)

    spawn(fn ->
      stream
      |> Stream.map(fn tweet -> send_reply(tweet, hashtag) end)
      |> Enum.to_list()
    end)
  end

  # t :: %ExTwitter.Model.Tweet{contributors: term, in_reply_to_status_id_str: term, filter_level: term, favorite_count: term, withheld_scope: term, scopes: term, geo: term, display_text_range: term, retweeted: term, entities: term, id_str: term, quoted_status_id_str: term, quoted_status_id: term, in_reply_to_user_id_str: term, quoted_status: term, created_at: term, user: term, possibly_sensitive: term, truncated: term, in_reply_to_status_id: term, source: term, extended_entities: term, favorited: term, text: term, withheld_in_countries: term, lang: term, id: term, withheld_copyright: term, retweet_count: term, place: term, current_user_retweet: term, coordinates: term, retweeted_status: term, in_reply_to_user_id: term, full_text: term, in_reply_to_screen_name: term}

  defp send_reply(tweet, hashtag) do
    IO.puts("Sending reply for hashtag: #{hashtag}")
    # IO.puts "#{tweet.user.screen_name}: #{tweet.text}\n---------------\n"
    # if tweet.user.screen_name == "chef_tschenko" do
    #   IO.puts "Wont reply to my own tweet."
    # else
    # ExTwitter.update("Ja genau: #{tweet.user.screen_name}, #{tweet.id_str}")
    # end
  end

  defp config_extwitter do
    ExTwitter.configure(
      consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
      consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
      access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
      access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
    )
  end
end
