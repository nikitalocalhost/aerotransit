defmodule Aerotransit.Repo.Migrations.CreateAirports do
  use Ecto.Migration

  def change do
    create table(:airports, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :country_id, references(:countries, on_delete: :nothing, type: :binary_id), null: false
      add :owner_id, references(:companies, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:airports, [:country_id])
    create index(:airports, [:owner_id])
  end
end
