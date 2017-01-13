defmodule Parteibot.Repo.Migrations.CreateTwitterAccount do
  use Ecto.Migration

  def change do
    create table(:twitter_accounts) do
      add :name, :string
      add :password, :string

      timestamps()
    end

  end
end
