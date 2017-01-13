defmodule Parteibot.AddTwitterAccountWithHashtagAndReplyMessagesTest do
  use Parteibot.AcceptanceCase

  test "add new twitter account with a hashtag and two reply_messages" do
    navigate_to("/")
    click({:name, "twitter_accounts"})
    create_twitter_account("die_partei", "twitter_password")
    navigate_to("/twitter_accounts/die_partei")
    create_hashtag("Steuern")
    navigate_to("/twitter_accounts/die_partei/Steuern")
    create_reply_message("Steuern rauf!")
    create_reply_message("Steuern runter!")
  end

  defp create_twitter_account(name, password) do
    click({:name, "new_twitter_account"})
    twitter_account_form = find_element(:tag, "form")
    twitter_account_form
    |> find_within_element(:id, "name")
    |> fill_field(name)

    twitter_account_form
    |> find_within_element(:id, "password")
    |> fill_field(password)

    submit_element(twitter_account_form)
  end

  defp create_hashtag(name) do
    click({:name, "new_hashtag"})
    hashtag_form = find_element(:tag, "form")
    hashtag_form
    |> find_within_element(:id, "name")
    |> fill_field(name)

    submit_element(hashtag_form)
  end

  defp create_reply_message(name) do
    click({:name, "new_reply_message"})
    hashtag_form = find_element(:tag, "form")
    hashtag_form
    |> find_within_element(:id, "name")
    |> fill_field(name)

    submit_element(hashtag_form)
  end
end
