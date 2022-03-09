defmodule Aerotransit.Repo.Migrations.CreateFlightPassengers do
  use Ecto.Migration

  def change do
    create table(:flight_passengers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :flight_id, references(:flights, on_delete: :nothing, type: :binary_id)
      add :passenger_id, references(:passengers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:flight_passengers, [:flight_id])
    create index(:flight_passengers, [:passenger_id])
  end
end
