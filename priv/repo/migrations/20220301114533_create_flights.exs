defmodule Aerotransit.Repo.Migrations.CreateFlights do
  use Ecto.Migration

  def change do
    create table(:flights, primary_key: false) do
      add :id, :binary_id, primary_key: true, null: false
      add :plane_id, references(:planes, on_delete: :nothing, type: :binary_id), null: false
      add :route_id, references(:routes, on_delete: :nothing, type: :binary_id)
      add :schedule_id, references(:schedules, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:flights, [:plane_id])
    create index(:flights, [:route_id])
    create index(:flights, [:schedule_id])
  end
end
