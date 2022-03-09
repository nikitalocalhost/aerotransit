defmodule Aerotransit.Repo.Migrations.CreateFlightCargo do
  use Ecto.Migration

  def change do
    create table(:flight_cargo, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :flight_id, references(:flights, on_delete: :nothing, type: :binary_id)
      add :cargo_id, references(:cargo, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:flight_cargo, [:flight_id])
    create index(:flight_cargo, [:cargo_id])
  end
end
