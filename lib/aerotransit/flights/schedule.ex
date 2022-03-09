defmodule Aerotransit.Flights.Schedule do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "schedules" do
    field :day, :integer
    field :start, :time

    belongs_to :route, Aerotransit.Flights.Route

    has_many :flights, Aerotransit.Flights.Flight

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:day, :start, :route_id])
    |> validate_required([:day, :start])
  end
end
