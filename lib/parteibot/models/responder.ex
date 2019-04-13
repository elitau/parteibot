defmodule Parteibot.Responder do
  @moduledoc """
  Send a tweet
  """
  require Logger

  def send_reply(tweet, hashtag) do
    Logger.info(
      "tweet: #{tweet.text}, Hashtag: #{hashtag.name}. I've replied with: #{
        Enum.random(hashtag.reply_messages).content
      }"
    )
  end
end
