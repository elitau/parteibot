defmodule Parteibot.Responder do
  @moduledoc """
  Send a tweet
  """
  require Logger

  def send_reply(tweet, hashtag) do
    reply_content = to_message(tweet, hashtag)

    Logger.info(
      "Hashtag: #{hashtag.name}; #{tweet.user.screen_name}: \"#{tweet.text}\"I've replied with: #{
        reply_content
      }"
    )

    reply_content |> tweet(in_reply_to_status_id: tweet.id)
  end

  def to_message(tweet, hashtag) do
    reply_content = Enum.random(hashtag.reply_messages).content
    "@#{tweet.user.screen_name} #{reply_content}"
  end

  def tweet(message, options) when is_binary(message) do
    if System.get_env("SEND_REPLY") == "true" do
      ExTwitter.update(message, options)
    else
      Logger.info("Did not send reply because SEND_REPLY != true")
    end
  end

  # t :: %ExTwitter.Model.Tweet{
  # contributors: term,
  # in_reply_to_status_id_str: term,
  # filter_level: term,
  # favorite_count: term,
  # withheld_scope: term,
  # scopes: term,
  # geo: term,
  # display_text_range: term,
  # retweeted: term,
  # entities: term,
  # id_str: term,
  # quoted_status_id_str: term,
  # quoted_status_id: term,
  # in_reply_to_user_id_str: term,
  # quoted_status: term,
  # created_at: term,
  # user: term,
  # possibly_sensitive: term,
  # truncated: term,
  # in_reply_to_status_id: term,
  # source: term,
  # extended_entities: term,
  # favorited: term,
  # text: term,
  # withheld_in_countries: term,
  # lang: term,
  # id: term,
  # withheld_copyright: term,
  # retweet_count: term,
  # place: term,
  # current_user_retweet: term,
  # coordinates: term,
  # retweeted_status: term,
  # in_reply_to_user_id: term,
  # full_text: term,
  # in_reply_to_screen_name: term}

  # defp send_reply(_tweet, hashtag) do
  #   IO.puts("Sending reply for hashtag: #{hashtag}")
  #   # IO.puts "#{tweet.user.screen_name}: #{tweet.text}\n---------------\n"
  #   # if tweet.user.screen_name == "chef_tschenko" do
  #   #   IO.puts "Wont reply to my own tweet."
  #   # else
  #   ExTwitter.update("#{tweet.user.screen_name}#{reply_content}")
  #   # end
  # end

  def config_extwitter do
    ExTwitter.configure(
      consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
      consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
      access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
      access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
    )
  end
end
