defmodule Parteibot.Repo.Migrations.CreateReplyMessage do
  use Ecto.Migration

  def change do
    create table(:reply_messages) do
      add :content, :text
      add :hashtag_id, references(:hashtags, on_delete: :nothing)

      timestamps()
    end
    create index(:reply_messages, [:hashtag_id])

  end
end
