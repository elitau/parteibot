defmodule Parteibot.Responder do
  require Logger
  def send_reply(tweet, hashtag) do
    Logger.info("tweet: #{tweet.text}, Hashtag: #{hashtag.name}")
  end
end