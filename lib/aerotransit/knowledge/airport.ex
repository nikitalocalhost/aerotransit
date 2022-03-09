defmodule Aerotransit.Knowledge.Airport do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "airports" do
    field :name, :string

    belongs_to :country, Aerotransit.Knowledge.Country
    belongs_to :owner, Aerotransit.Knowledge.Company

    has_many :planes, Aerotransit.Knowledge.Plane

    has_many :routes_from, Aerotransit.Flights.Route, foreign_key: :from_id
    has_many :routes_to, Aerotransit.Flights.Route, foreign_key: :to_id

    timestamps()
  end

  @doc false
  def changeset(airport, attrs) do
    airport
    |> cast(attrs, [:name, :country_id, :owner_id])
    |> validate_required([:name])
  end
end
