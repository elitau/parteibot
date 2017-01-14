defmodule Parteibot.ReplyMessage do
  use Parteibot.Web, :model

  schema "reply_messages" do
    field :content, :string
    belongs_to :hashtag, Parteibot.Hashtag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
