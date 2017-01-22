defmodule Parteibot.AddTwitterAccountWithHashtagAndReplyMessagesTest do
  use Parteibot.AcceptanceCase

  test "add new twitter account with a hashtag and two reply_messages" do
    navigate_to("/")
    click({:name, "twitter_accounts"})
    create_twitter_account("die_partei", "twitter_password")
    visit_twitter_account
    create_hashtag("Steuern")
    visit_hashtag
    create_reply_message("Steuern rauf!")
  end

  defp create_twitter_account(name, password) do
    click({:name, "new_twitter_account"})
    twitter_account_form = find_element(:tag, "form")
    twitter_account_form
    |> find_within_element(:id, "twitter_account_name")
    |> fill_field(name)

    twitter_account_form
    |> find_within_element(:id, "twitter_account_password")
    |> fill_field(password)

    submit_element(twitter_account_form)
  end

  defp create_hashtag(name) do
    hashtag_form = find_element(:tag, "form")
    hashtag_form
    |> find_within_element(:id, "hashtag_name")
    |> fill_field(name)

    submit_element(hashtag_form)

    hashtag_visible(name)
  end

  defp hashtag_visible(name) do
    find_element(:tag, "tbody")
    |> find_within_element(:tag, "tr")
    |> visible_text
    |> String.contains?(name)
  end

  defp create_reply_message(name) do
    hashtag_form = find_element(:tag, "form")
    hashtag_form
    |> find_within_element(:id, "reply_message_content")
    |> fill_field(name)

    submit_element(hashtag_form)

    reply_message_visible(name)
  end

  defp reply_message_visible(name) do
    find_element(:tag, "tbody")
    |> find_within_element(:tag, "tr")
    |> visible_text
    |> String.contains?(name)
  end

  defp visit_twitter_account do
    click({:link_text, "Show"})
  end

  defp visit_hashtag do
    click({:link_text, "Show"})
  end
end
