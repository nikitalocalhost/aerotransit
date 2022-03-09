defmodule Aerotransit.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Aerotransit.Accounts` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name",
        priveleges: []
      })
      |> Aerotransit.Accounts.create_role()

    role
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}, role \\ role_fixture()) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "some password",
        username: "some username",
        role_id: role.id
      })
      |> Aerotransit.Accounts.create_user()

    user
  end
end
