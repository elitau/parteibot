defmodule Parteibot.StreamWatcher do
  use GenServer
  require Logger
  defstruct hashtag: nil, twitter_stream: nil

  def start_link(hashtag) do
    GenServer.start_link(__MODULE__, hashtag)
  end

  def init(hashtag) do
    send(self(), :start_streaming)
    {:ok, hashtag}
  end

  def handle_info(:start_streaming, hashtag) do
    spawn_link(fn ->
      config_extwitter(hashtag)

      twitter_stream =
        ExTwitter.stream_filter([track: hashtag.name], :infinity)
        |> Stream.filter(fn tweet -> handle_hashtag_mention(tweet, hashtag) end)

      Enum.to_list(twitter_stream)
    end)

    {:noreply, hashtag}
  end

  defp handle_hashtag_mention(tweet, hashtag) do
    Parteibot.Responder.send_reply(tweet, hashtag)
    # IO.inspect(hashtag)
    # IO.inspect(tweet.text)
    # Logger.info("Hashtag '#{hashtag.name}' mentionend in '#{tweet.text}'")
    tweet
  end

  defp config_extwitter(hashtag) do
    ExTwitter.configure(:process,
      consumer_key: consumer_key(),
      consumer_secret: consumer_secret(),
      access_token: access_token(hashtag),
      access_token_secret: access_token_secret(hashtag)
    )
  end

  defp consumer_key do
    Application.get_env(:ueberauth, Ueberauth.Strategy.Twitter.OAuth)[:consumer_key]
  end

  defp consumer_secret do
    Application.get_env(:ueberauth, Ueberauth.Strategy.Twitter.OAuth)[:consumer_secret]
  end

  defp access_token(hashtag) do
    # hashtag.twitter_account.access_token
    System.get_env("TWITTER_ACCESS_TOKEN")
  end

  defp access_token_secret(hashtag) do
    # hashtag.twitter_account.access_token_secret
    System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
  end
end
