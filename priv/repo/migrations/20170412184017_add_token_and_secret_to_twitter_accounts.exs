defmodule Parteibot.Repo.Migrations.AddTokenAndSecretToTwitterAccounts do
  use Ecto.Migration

  def change do
    alter table(:twitter_accounts) do
      add :access_token, :string
      add :access_token_secret, :string
    end
  end
end
