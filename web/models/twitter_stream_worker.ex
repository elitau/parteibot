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
    stream = ExTwitter.stream_filter(track: "#Steuern")
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

  defp send_reply(tweet) do
    # IO.puts "#{tweet.text}\n---------------\n"
    ExTwitter.update("Steuern rauf: #{String.slice(tweet.text, 0..100)}")
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
