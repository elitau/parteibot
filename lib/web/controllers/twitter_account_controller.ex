defmodule Web.TwitterAccountController do
  use Web, :controller

  alias Parteibot.TwitterAccount

  def index(conn, _params) do
    twitter_accounts = Repo.all(TwitterAccount)
    render(conn, "index.html", twitter_accounts: twitter_accounts)
  end

  def new(conn, _params) do
    changeset = TwitterAccount.changeset(%TwitterAccount{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"twitter_account" => twitter_account_params}) do
    changeset = TwitterAccount.changeset(%TwitterAccount{}, twitter_account_params)

    case Repo.insert(changeset) do
      {:ok, _twitter_account} ->
        conn
        |> put_flash(:info, "Twitter account created successfully.")
        |> redirect(to: twitter_account_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    twitter_account = Repo.get!(TwitterAccount, id) |> Repo.preload([:hashtags])
    hashtag_changeset = Parteibot.Hashtag.changeset(%Parteibot.Hashtag{})

    render(
      conn,
      "show.html",
      twitter_account: twitter_account,
      hashtag_changeset: hashtag_changeset
    )
  end

  def edit(conn, %{"id" => id}) do
    twitter_account = Repo.get!(TwitterAccount, id)
    changeset = TwitterAccount.changeset(twitter_account)
    render(conn, "edit.html", twitter_account: twitter_account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "twitter_account" => twitter_account_params}) do
    twitter_account = Repo.get!(TwitterAccount, id)
    changeset = TwitterAccount.changeset(twitter_account, twitter_account_params)

    case Repo.update(changeset) do
      {:ok, twitter_account} ->
        conn
        |> put_flash(:info, "Twitter account updated successfully.")
        |> redirect(to: twitter_account_path(conn, :show, twitter_account))

      {:error, changeset} ->
        render(conn, "edit.html", twitter_account: twitter_account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    twitter_account = Repo.get!(TwitterAccount, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(twitter_account)

    conn
    |> put_flash(:info, "Twitter account deleted successfully.")
    |> redirect(to: twitter_account_path(conn, :index))
  end
end
