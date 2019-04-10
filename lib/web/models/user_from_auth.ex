defmodule UserFromAuth do
  @moduledoc """
  Retrieve the user information from an auth request
  """

  alias Ueberauth.Auth

  def find_or_create(%Auth{provider: :identity} = auth) do
    case validate_pass(auth.credentials) do
      :ok ->
        {:ok, basic_info(auth)}
      {:error, reason} -> {:error, reason}
    end
  end

  def find_or_create(%Auth{} = auth) do
    {:ok, basic_info(auth)}
  end

  defp basic_info(auth) do
    %{
      id: auth.uid,
      name: name_from_auth(auth),
      avatar: auth.info.image,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
      name: auth.info.nickname
    }
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name = [auth.info.first_name, auth.info.last_name]
      |> Enum.filter(&(&1 != nil and &1 != ""))

      cond do
        length(name) == 0 -> auth.info.nickname
        true -> Enum.join(name, " ")
      end
    end
  end

  defp validate_pass(%{other: %{password: ""}}) do
    {:error, "Password required"}
  end
  defp validate_pass(%{other: %{password: pw, password_confirmation: pw}}) do
    :ok
  end
  defp validate_pass(%{other: %{password: _}}) do
    {:error, "Passwords do not match"}
  end
  defp validate_pass(_), do: {:error, "Password Required"}
end

# %Ueberauth.Auth{credentials: %Ueberauth.Auth.Credentials{expires: nil,
#   expires_at: nil, other: %{}, refresh_token: nil, scopes: [],
#   secret: "6Q4uCQQCEje9ZfkfP78a1N1rPv5xiTLfaDezaXtiw1E8K",
#   token: "824746817489346560-nYQWRRlgniXdq6SB7NLlW2pNhMahG3y", token_type: nil},
#  extra: %Ueberauth.Auth.Extra{raw_info: %{token: "Q2T4ogAAAAAA0D09AAABW2NtO3A",
#     user: %{"protected" => false, "id_str" => "824746817489346560",
#       "friends_count" => 16, "has_extended_profile" => true,
#       "followers_count" => 0, "following" => false, "default_profile" => false,
#       "translator_type" => "none", "profile_sidebar_fill_color" => "000000",
#       "id" => 824746817489346560,
#       "profile_image_url" => "http://pbs.twimg.com/profile_images/824750933586358272/qbk3gTzz_normal.jpg",
#       "profile_link_color" => "E81C4F", "is_translation_enabled" => false,
#       "verified" => false, "utc_offset" => nil,
#       "profile_sidebar_border_color" => "000000", "statuses_count" => 1,
#       "profile_text_color" => "000000", "is_translator" => false,
#       "lang" => "en",
#       "profile_background_image_url_https" => "https://abs.twimg.com/images/themes/theme1/bg.png",
#       "listed_count" => 0, "location" => "Астана",
#       "contributors_enabled" => false,
#       "profile_background_image_url" => "http://abs.twimg.com/images/themes/theme1/bg.png",
#       "created_at" => "Thu Jan 26 22:32:19 +0000 2017", "name" => "Partei Bot",
#       "profile_background_color" => "000000", "notifications" => false,
#       "entities" => %{"description" => %{"urls" => []}}, "url" => nil,
#       "profile_background_tile" => false, "default_profile_image" => false,
#       "description" => "I help to reintroduce profanity into politics.",
#       "favourites_count" => 0, "geo_enabled" => false,
#       "profile_image_url_https" => "https://pbs.twimg.com/profile_images/824750933586358272/qbk3gTzz_normal.jpg",
#       "profile_use_background_image" => false, "time_zone" => nil,
#       "follow_request_sent" => false, "screen_name" => "parteibot"}}},
#  info: %Ueberauth.Auth.Info{description: "I help to reintroduce profanity into politics.",
#   email: nil, first_name: nil,
#   image: "http://pbs.twimg.com/profile_images/824750933586358272/qbk3gTzz_normal.jpg",
#   last_name: nil, location: nil, name: "Partei Bot", nickname: "parteibot",
#   phone: nil, urls: %{Twitter: "https://twitter.com/parteibot", Website: nil}},
#  provider: :twitter, strategy: Ueberauth.Strategy.Twitter,
#  uid: "824746817489346560"}