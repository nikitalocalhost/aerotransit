defmodule Aerotransit.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string, null: false
      add :password_hash, :string, null: false
      add :role_id, references(:roles, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:users, [:role_id])
  end
end
