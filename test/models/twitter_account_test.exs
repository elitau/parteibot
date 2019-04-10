defmodule Parteibot.TwitterAccountTest do
  use Parteibot.ModelCase

  alias Parteibot.TwitterAccount

  @valid_attrs %{
    name: "some content",
    password: "some content",
    access_token: "access_token",
    access_token_secret: "access_token_secret"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TwitterAccount.changeset(%TwitterAccount{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TwitterAccount.changeset(%TwitterAccount{}, @invalid_attrs)
    refute changeset.valid?
  end
end
