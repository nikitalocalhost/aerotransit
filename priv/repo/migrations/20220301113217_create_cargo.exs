defmodule Aerotransit.Repo.Migrations.CreateCargo do
  use Ecto.Migration

  def change do
    create table(:cargo, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :weight, :integer, null: false
      add :type_id, references(:cargo_types, on_delete: :nothing, type: :binary_id), null: false
      add :company_id, references(:companies, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:cargo, [:type_id])
    create index(:cargo, [:company_id])
  end
end
