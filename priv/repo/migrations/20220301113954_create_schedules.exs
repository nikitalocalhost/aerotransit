defmodule Aerotransit.Repo.Migrations.CreateSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :day, :integer, null: false
      add :start, :time, null: false
      add :route_id, references(:routes, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:schedules, [:route_id])
  end
end
