defmodule Parteibot.ReplyMessageTest do
  use Parteibot.ModelCase

  alias Parteibot.ReplyMessage

  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ReplyMessage.changeset(%ReplyMessage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ReplyMessage.changeset(%ReplyMessage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
