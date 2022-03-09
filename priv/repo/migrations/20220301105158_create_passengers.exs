defmodule Aerotransit.Repo.Migrations.CreatePassengers do
  use Ecto.Migration

  def change do
    create table(:passengers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :passport, :string, null: false
      add :full_name, :string, null: false
      add :age, :integer, null: false
      add :sex, :boolean, default: false, null: false
      add :country_id, references(:countries, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:passengers, [:passport])
    create index(:passengers, [:country_id])
  end
end
