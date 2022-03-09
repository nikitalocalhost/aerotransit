defmodule Aerotransit.Flights.Route do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "routes" do
    field :duration, :integer
    belongs_to :from, Aerotransit.Knowledge.Airport
    belongs_to :to, Aerotransit.Knowledge.Airport

    has_many :schedules, Aerotransit.Flights.Schedule
    has_many :flights, Aerotransit.Flights.Flight

    timestamps()
  end

  @doc false
  def changeset(route, attrs) do
    route
    |> cast(attrs, [:duration, :from_id, :to_id])
    |> validate_required([:duration])
  end
end
