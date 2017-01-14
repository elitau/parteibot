defmodule Parteibot.TwitterAccount do
  use Parteibot.Web, :model

  schema "twitter_accounts" do
    field :name, :string
    field :password, :string

    has_many :hashtags, Parteibot.Hashtag
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :password])
    |> validate_required([:name, :password])
  end
end
