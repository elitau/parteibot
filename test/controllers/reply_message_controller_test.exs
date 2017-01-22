defmodule Parteibot.ReplyMessageControllerTest do
  use Parteibot.ConnCase

  # alias Parteibot.ReplyMessage
  # @valid_attrs %{content: "some content"}
  # @invalid_attrs %{}

  # test "lists all entries on index", %{conn: conn} do
  #   conn = get conn, reply_message_path(conn, :index)
  #   assert html_response(conn, 200) =~ "Listing reply messages"
  # end

  # test "renders form for new resources", %{conn: conn} do
  #   conn = get conn, reply_message_path(conn, :new)
  #   assert html_response(conn, 200) =~ "New reply message"
  # end

  # test "creates resource and redirects when data is valid", %{conn: conn} do
  #   conn = post conn, reply_message_path(conn, :create), reply_message: @valid_attrs
  #   assert redirected_to(conn) == reply_message_path(conn, :index)
  #   assert Repo.get_by(ReplyMessage, @valid_attrs)
  # end

  # test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  #   conn = post conn, reply_message_path(conn, :create), reply_message: @invalid_attrs
  #   assert html_response(conn, 200) =~ "New reply message"
  # end

  # test "shows chosen resource", %{conn: conn} do
  #   reply_message = Repo.insert! %ReplyMessage{}
  #   conn = get conn, reply_message_path(conn, :show, reply_message)
  #   assert html_response(conn, 200) =~ "Show reply message"
  # end

  # test "renders page not found when id is nonexistent", %{conn: conn} do
  #   assert_error_sent 404, fn ->
  #     get conn, reply_message_path(conn, :show, -1)
  #   end
  # end

  # test "renders form for editing chosen resource", %{conn: conn} do
  #   reply_message = Repo.insert! %ReplyMessage{}
  #   conn = get conn, reply_message_path(conn, :edit, reply_message)
  #   assert html_response(conn, 200) =~ "Edit reply message"
  # end

  # test "updates chosen resource and redirects when data is valid", %{conn: conn} do
  #   reply_message = Repo.insert! %ReplyMessage{}
  #   conn = put conn, reply_message_path(conn, :update, reply_message), reply_message: @valid_attrs
  #   assert redirected_to(conn) == reply_message_path(conn, :show, reply_message)
  #   assert Repo.get_by(ReplyMessage, @valid_attrs)
  # end

  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   reply_message = Repo.insert! %ReplyMessage{}
  #   conn = put conn, reply_message_path(conn, :update, reply_message), reply_message: @invalid_attrs
  #   assert html_response(conn, 200) =~ "Edit reply message"
  # end

  # test "deletes chosen resource", %{conn: conn} do
  #   reply_message = Repo.insert! %ReplyMessage{}
  #   conn = delete conn, reply_message_path(conn, :delete, reply_message)
  #   assert redirected_to(conn) == reply_message_path(conn, :index)
  #   refute Repo.get(ReplyMessage, reply_message.id)
  # end
end
