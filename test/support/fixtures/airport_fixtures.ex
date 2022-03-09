defmodule Aerotransit.AirportFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Aerotransit.Airport` context.
  """

  @doc """
  Generate a unique country name.
  """
  def unique_country_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a country.
  """
  def country_fixture(attrs \\ %{}) do
    {:ok, country} =
      attrs
      |> Enum.into(%{
        name: unique_country_name()
      })
      |> Aerotransit.Airport.create_country()

    country
  end

  @doc """
  Generate a unique passenger passport.
  """
  def unique_passenger_passport, do: "some passport#{System.unique_integer([:positive])}"

  @doc """
  Generate a passenger.
  """
  def passenger_fixture(attrs \\ %{}) do
    {:ok, passenger} =
      attrs
      |> Enum.into(%{
        age: 42,
        full_name: "some full_name",
        passport: unique_passenger_passport(),
        sex: true
      })
      |> Aerotransit.Airport.create_passenger()

    passenger
  end

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        government: true,
        name: "some name",
        register: "some register"
      })
      |> Aerotransit.Airport.create_company()

    company
  end
end
