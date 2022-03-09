defmodule Aerotransit.Repo.Migrations.CreatePlanes do
  use Ecto.Migration

  def change do
    create table(:planes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string, null: false
      add :type_id, references(:plane_types, on_delete: :nothing, type: :binary_id), null: false
      add :company_id, references(:companies, on_delete: :nothing, type: :binary_id), null: false
      add :airport_id, references(:airports, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:planes, [:code])
    create index(:planes, [:type_id])
    create index(:planes, [:company_id])
    create index(:planes, [:airport_id])
  end
end
