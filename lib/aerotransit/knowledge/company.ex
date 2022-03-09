defmodule Aerotransit.Knowledge.Company do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "companies" do
    field :government, :boolean, default: false
    field :name, :string
    field :register, :string
    belongs_to :country, Aerotransit.Knowledge.Country

    has_many :airports, Aerotransit.Knowledge.Airport, foreign_key: :owner_id
    has_many :planes, Aerotransit.Knowledge.Plane
    has_many :cargo, Aerotransit.Flights.Cargo

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:register, :name, :government, :country_id])
    |> validate_required([:register, :name, :government])
  end
end
