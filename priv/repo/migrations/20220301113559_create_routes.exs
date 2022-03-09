defmodule Aerotransit.Repo.Migrations.CreateRoutes do
  use Ecto.Migration

  def change do
    create table(:routes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :duration, :integer, null: false
      add :from_id, references(:airports, on_delete: :nothing, type: :binary_id), null: false
      add :to_id, references(:airports, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:routes, [:from_id])
    create index(:routes, [:to_id])
  end
end
