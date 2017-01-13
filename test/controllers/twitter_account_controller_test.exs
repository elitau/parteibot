defmodule Parteibot.TwitterAccountControllerTest do
  use Parteibot.ConnCase

  alias Parteibot.TwitterAccount
  @valid_attrs %{name: "some content", password: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, twitter_account_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing twitter accounts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, twitter_account_path(conn, :new)
    assert html_response(conn, 200) =~ "New twitter account"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, twitter_account_path(conn, :create), twitter_account: @valid_attrs
    assert redirected_to(conn) == twitter_account_path(conn, :index)
    assert Repo.get_by(TwitterAccount, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, twitter_account_path(conn, :create), twitter_account: @invalid_attrs
    assert html_response(conn, 200) =~ "New twitter account"
  end

  test "shows chosen resource", %{conn: conn} do
    twitter_account = Repo.insert! %TwitterAccount{}
    conn = get conn, twitter_account_path(conn, :show, twitter_account)
    assert html_response(conn, 200) =~ "Show twitter account"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, twitter_account_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    twitter_account = Repo.insert! %TwitterAccount{}
    conn = get conn, twitter_account_path(conn, :edit, twitter_account)
    assert html_response(conn, 200) =~ "Edit twitter account"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    twitter_account = Repo.insert! %TwitterAccount{}
    conn = put conn, twitter_account_path(conn, :update, twitter_account), twitter_account: @valid_attrs
    assert redirected_to(conn) == twitter_account_path(conn, :show, twitter_account)
    assert Repo.get_by(TwitterAccount, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    twitter_account = Repo.insert! %TwitterAccount{}
    conn = put conn, twitter_account_path(conn, :update, twitter_account), twitter_account: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit twitter account"
  end

  test "deletes chosen resource", %{conn: conn} do
    twitter_account = Repo.insert! %TwitterAccount{}
    conn = delete conn, twitter_account_path(conn, :delete, twitter_account)
    assert redirected_to(conn) == twitter_account_path(conn, :index)
    refute Repo.get(TwitterAccount, twitter_account.id)
  end
end
