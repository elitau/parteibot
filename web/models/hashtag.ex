defmodule Parteibot.Hashtag do
  use Parteibot.Web, :model

  schema "hashtags" do
    field :name, :string

    belongs_to :twitter_account, Parteibot.TwitterAccount
    has_many :reply_messages, Parteibot.ReplyMessage
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :twitter_account_id])
    |> validate_required([:name])
  end
end
