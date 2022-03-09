defmodule Aerotransit.Flights.FlightPassengers do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "flight_passengers" do
    belongs_to :flight, Aerotransit.Flights.Flight
    belongs_to :passenger, Aerotransit.Knowledge.Passenger

    timestamps()
  end

  @doc false
  def changeset(flight_passengers, attrs) do
    flight_passengers
    |> cast(attrs, [:flight_id, :passenger_id])
    |> validate_required([])
  end
end
