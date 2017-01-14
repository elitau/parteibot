defmodule Parteibot.HashtagControllerTest do
  use Parteibot.ConnCase

  alias Parteibot.Hashtag
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, hashtag_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing hashtags"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, hashtag_path(conn, :new)
    assert html_response(conn, 200) =~ "New hashtag"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, hashtag_path(conn, :create), hashtag: @valid_attrs
    assert redirected_to(conn) == hashtag_path(conn, :index)
    assert Repo.get_by(Hashtag, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hashtag_path(conn, :create), hashtag: @invalid_attrs
    assert html_response(conn, 200) =~ "New hashtag"
  end

  test "shows chosen resource", %{conn: conn} do
    hashtag = Repo.insert! %Hashtag{}
    conn = get conn, hashtag_path(conn, :show, hashtag)
    assert html_response(conn, 200) =~ "Show hashtag"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, hashtag_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    hashtag = Repo.insert! %Hashtag{}
    conn = get conn, hashtag_path(conn, :edit, hashtag)
    assert html_response(conn, 200) =~ "Edit hashtag"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    hashtag = Repo.insert! %Hashtag{}
    conn = put conn, hashtag_path(conn, :update, hashtag), hashtag: @valid_attrs
    assert redirected_to(conn) == hashtag_path(conn, :show, hashtag)
    assert Repo.get_by(Hashtag, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    hashtag = Repo.insert! %Hashtag{}
    conn = put conn, hashtag_path(conn, :update, hashtag), hashtag: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit hashtag"
  end

  test "deletes chosen resource", %{conn: conn} do
    hashtag = Repo.insert! %Hashtag{}
    conn = delete conn, hashtag_path(conn, :delete, hashtag)
    assert redirected_to(conn) == hashtag_path(conn, :index)
    refute Repo.get(Hashtag, hashtag.id)
  end
end
