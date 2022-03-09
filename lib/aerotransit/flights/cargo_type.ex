defmodule Aerotransit.Flights.CargoType do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cargo_types" do
    field :name, :string

    has_many :cargo, Aerotransit.Flights.Cargo, foreign_key: :type_id

    timestamps()
  end

  @doc false
  def changeset(cargo_type, attrs) do
    cargo_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
