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

  # {place: nil, in_reply_to_screen_name: nil, source: "<a href=\"http://twitter.com/download/iphone\" rel=\"nofollow\">Twitter for iPhone</a>", coordinates: nil, retweeted_status: nil, favorite_count: 0, truncated: false, user: %ExTwitter.Model.User{profile_image_url: "http://pbs.twimg.com/profile_images/826052444681601025/OvMfVBTW_normal.jpg", verified: true, name: "Kirkity", statuses_count: 2783, friends_count: 1048, profile_link_color: "1B95E0", profile_background_color: "000000", status: nil, profile_banner_url: "https://pbs.twimg.com/profile_banners/3156046382/1481124540", profile_sidebar_border_color: "000000", profile_use_background_image: false, profile_sidebar_fill_color: "000000", show_all_inline_media: nil, location: "Bad Kreuznach", utc_offset: nil, is_translation_enabled: nil, withheld_scope: nil, default_profile_image: false, email: nil, screen_name: "KirkityYT", profile_background_image_url: "http://abs.twimg.com/images/themes/theme1/bg.png", following: nil, followers_count: 13509, is_translator: false, geo_enabled: true, time_zone: nil, created_at: "Tue Apr 14 12:48:20 +0000 2015", follow_request_sent: nil, notifications: nil, id_str: "3156046382", default_profile: false, listed_count: 18, id: 3156046382, url: "http://www.younow.com/kirkity", protected: false, profile_background_tile: false, profile_background_image_url_https: "https://abs.twimg.com/images/themes/theme1/bg.png", lang: "de", contributors_enabled: false, entities: nil, withheld_in_countries: nil, profile_text_color: "000000", ...}, in_reply_to_user_id: nil, withheld_scope: nil, full_text: nil, in_reply_to_user_id_str: nil, withheld_copyright: nil, extended_entities: nil, display_text_range: nil, in_reply_to_status_id_str: nil, created_at: "Sat Feb 04 16:22:10 +0000 2017", filter_level: "low", id_str: "827915157980512258", favorited: false, geo: nil, id: 827915157980512258, retweet_count: 0, quoted_status: nil, quoted_status_id_str: nil, contributors: nil, current_user_retweet: nil, scopes: nil, quoted_status_id: nil, lang: "de", retweeted: false, entities: %{hashtags: [], symbols: [], urls: [], user_mentions: []}, withheld_in_countries: nil, in_reply_to_status_id: nil, possibly_sensitive: nil, text: "So geil, wenn man mit Spotify auf dem Handy vom Bett aus über WLAN steuern kann, welche Musik der PC auf den großen Boxen spielen soll.🔥✌🏼️"}

  defp send_reply(tweet) do
    IO.puts "#{tweet.user.screen_name}: #{tweet.text}\n---------------\n"
    if tweet.user.screen_name == "chef_tschenko" do
      IO.puts "Wont reply to my own tweet."
    else
      ExTwitter.update("Steuern rauf: #{String.slice(tweet.text, 0..100)}")
    end
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
