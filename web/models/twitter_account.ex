defmodule Parteibot.TwitterAccount do
  use Parteibot.Web, :model

  schema "twitter_accounts" do
    field :name, :string
    field :password, :string
    field :access_token, :string
    field :access_token_secret, :string

    has_many :hashtags, Parteibot.Hashtag
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :access_token, :access_token_secret])
    |> validate_required([:name, :access_token, :access_token_secret])
    |> unique_constraint(:name)
  end

  def create_or_update(twitter_account_params) do
    unless account_exists?(twitter_account_params) do
      Parteibot.TwitterAccount.changeset(%Parteibot.TwitterAccount{}, twitter_account_params)
      |> Parteibot.Repo.insert
    end
  end

  def account_exists?(twitter_account_params) do
    query = from ta in Parteibot.TwitterAccount,
            where: ta.name == ^twitter_account_params.name
    Parteibot.Repo.one(query)
  end
end
