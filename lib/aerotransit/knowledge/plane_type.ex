defmodule Aerotransit.Knowledge.PlaneType do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "plane_types" do
    field :name, :string

    has_many :planes, Aerotransit.Knowledge.Plane, foreign_key: :type_id

    timestamps()
  end

  @doc false
  def changeset(plane_type, attrs) do
    plane_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
