defmodule Aerotransit.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :register, :string
      add :name, :string, null: false
      add :government, :boolean, default: false, null: false
      add :country_id, references(:countries, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:companies, [:country_id])
  end
end
