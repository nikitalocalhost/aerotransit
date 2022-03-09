defmodule Aerotransit.Knowledge.Passenger do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "passengers" do
    field :age, :integer
    field :full_name, :string
    field :passport, :string
    field :sex, :boolean, default: false

    belongs_to :country, Aerotransit.Knowledge.Country

    many_to_many :flights, Aerotransit.Flights.Flight, join_through: "flight_passengers"

    timestamps()
  end

  @doc false
  def changeset(passenger, attrs) do
    passenger
    |> cast(attrs, [:passport, :full_name, :age, :sex, :country_id])
    |> validate_required([:passport, :full_name, :age, :sex])
    |> unique_constraint(:passport)
  end
end
