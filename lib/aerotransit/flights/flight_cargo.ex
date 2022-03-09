defmodule Aerotransit.Flights.FlightCargo do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "flight_cargo" do
    belongs_to :flight, Aerotransit.Flights.Flight
    belongs_to :cargo, Aerotransit.Flights.Cargo

    timestamps()
  end

  @doc false
  def changeset(flight_cargo, attrs) do
    flight_cargo
    |> cast(attrs, [:flight_id, :cargo_id])
    |> validate_required([])
  end
end
