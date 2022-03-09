defmodule Aerotransit.Accounts.Role do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Aerotransit.Accounts

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "roles" do
    field :name, :string
    field :priveleges, {:array, :string}
    has_many :users, Accounts.User

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :priveleges])
    |> validate_required([:name, :priveleges])
    |> unique_constraint(:name)
  end
end
