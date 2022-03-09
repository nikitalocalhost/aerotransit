defmodule Aerotransit.Repo.Migrations.CreateCargoTypes do
  use Ecto.Migration

  def change do
    create table(:cargo_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:cargo_types, [:name])
  end
end
