defmodule Aerotransit.Flights.Flight do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "flights" do
    belongs_to :plane, Aerotransit.Knowledge.Plane
    belongs_to :route, Aerotransit.Flights.Route
    belongs_to :schedule, Aerotransit.Flights.Schedule

    many_to_many :passengers, Aerotransit.Knowledge.Passenger, join_through: "flight_passengers"
    many_to_many :cargo, Aerotransit.Flights.Cargo, join_through: "flight_cargo"

    timestamps()
  end

  @doc false
  def changeset(flight, attrs) do
    flight
    |> cast(attrs, [:plane_id, :route_id, :schedule_id])
    |> validate_required([])
  end
end
