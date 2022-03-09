defmodule Aerotransit.Flights.Cargo do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cargo" do
    field :weight, :integer

    belongs_to :type, Aerotransit.Flights.CargoType
    belongs_to :company, Aerotransit.Knowledge.Company

    many_to_many :cargo, Aerotransit.Flights.Flight, join_through: "flight_cargo"

    timestamps()
  end

  @doc false
  def changeset(cargo, attrs) do
    cargo
    |> cast(attrs, [:weight, :type_id, :company_id])
    |> validate_required([:weight])
  end
end
