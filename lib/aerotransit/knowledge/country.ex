defmodule Aerotransit.Knowledge.Country do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "countries" do
    field :name, :string

    has_many :companies, Aerotransit.Knowledge.Company
    has_many :airports, Aerotransit.Knowledge.Airport
    has_many :passengers, Aerotransit.Knowledge.Passenger

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
