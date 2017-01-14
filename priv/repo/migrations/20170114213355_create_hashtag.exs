defmodule Parteibot.Repo.Migrations.CreateHashtag do
  use Ecto.Migration

  def change do
    create table(:hashtags) do
      add :name, :string
      add :twitter_account_id, references(:twitter_accounts, on_delete: :nothing)

      timestamps()
    end
    create index(:hashtags, [:twitter_account_id])

  end
end
