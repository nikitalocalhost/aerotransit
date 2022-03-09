defmodule Aerotransit.Knowledge.Plane do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "planes" do
    field :code, :string

    belongs_to :type, Aerotransit.Knowledge.PlaneType
    belongs_to :company, Aerotransit.Knowledge.Company
    belongs_to :airport, Aerotransit.Knowledge.Airport

    has_many :flights, Aerotransit.Flights.Flight

    timestamps()
  end

  @doc false
  def changeset(plane, attrs) do
    plane
    |> cast(attrs, [:code, :type_id, :company_id, :airport_id])
    |> validate_required([:code])
    |> unique_constraint(:code)
  end
end
