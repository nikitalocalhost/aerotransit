defmodule Aerotransit.Accounts.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    field :role, :binary_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> password_changeset(attrs)
  end

  defp password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> put_pass_hash()
    |> put_change(:password, nil)
  end

  defp put_pass_hash(changeset = %Ecto.Changeset{valid?: true, changes: %{password: password}}) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
