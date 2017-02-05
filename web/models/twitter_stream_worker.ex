defmodule Parteibot.TwitterStreamWorker do
  use GenServer

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
    config_extwitter
    pid = start_stream
    {:ok, pid}
  end

  defp start_stream do
    stream = ExTwitter.stream_filter(track: "Steuern")
    IO.puts "Spawning stream watch process"
    #   |> Stream.map(fn(x) -> x.text end)
    #   |> Stream.map(fn(x) -> IO.puts "#{x}\n---------------\n" end)
    # Enum.to_list(stream)
    spawn(
      fn -> stream
            |> Stream.map(fn(tweet) -> send_reply(tweet) end)
            |> Enum.to_list
      end
    )
  end

  # t :: %ExTwitter.Model.Tweet{contributors: term, in_reply_to_status_id_str: term, filter_level: term, favorite_count: term, withheld_scope: term, scopes: term, geo: term, display_text_range: term, retweeted: term, entities: term, id_str: term, quoted_status_id_str: term, quoted_status_id: term, in_reply_to_user_id_str: term, quoted_status: term, created_at: term, user: term, possibly_sensitive: term, truncated: term, in_reply_to_status_id: term, source: term, extended_entities: term, favorited: term, text: term, withheld_in_countries: term, lang: term, id: term, withheld_copyright: term, retweet_count: term, place: term, current_user_retweet: term, coordinates: term, retweeted_status: term, in_reply_to_user_id: term, full_text: term, in_reply_to_screen_name: term}

  defp send_reply(tweet) do
    IO.puts "Sending reply"
    IO.puts "#{tweet.user.screen_name}: #{tweet.text}\n---------------\n"
    # if tweet.user.screen_name == "chef_tschenko" do
    #   IO.puts "Wont reply to my own tweet."
    # else
    ExTwitter.update("Ja genau: #{tweet.user.screen_name}, #{tweet.id_str}")
    # end
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
