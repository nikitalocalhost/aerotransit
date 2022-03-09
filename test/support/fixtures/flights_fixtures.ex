defmodule Aerotransit.FlightsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Aerotransit.Flights` context.
  """

  @doc """
  Generate a unique cargo_type name.
  """
  def unique_cargo_type_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a cargo_type.
  """
  def cargo_type_fixture(attrs \\ %{}) do
    {:ok, cargo_type} =
      attrs
      |> Enum.into(%{
        name: unique_cargo_type_name()
      })
      |> Aerotransit.Flights.create_cargo_type()

    cargo_type
  end

  @doc """
  Generate a cargo.
  """
  def cargo_fixture(attrs \\ %{}) do
    {:ok, cargo} =
      attrs
      |> Enum.into(%{
        weight: 42
      })
      |> Aerotransit.Flights.create_cargo()

    cargo
  end

  @doc """
  Generate a route.
  """
  def route_fixture(attrs \\ %{}) do
    {:ok, route} =
      attrs
      |> Enum.into(%{
        duration: 42
      })
      |> Aerotransit.Flights.create_route()

    route
  end

  @doc """
  Generate a schedule.
  """
  def schedule_fixture(attrs \\ %{}) do
    {:ok, schedule} =
      attrs
      |> Enum.into(%{
        day: 42,
        start: ~T[14:00:00]
      })
      |> Aerotransit.Flights.create_schedule()

    schedule
  end

  @doc """
  Generate a flight.
  """
  def flight_fixture(attrs \\ %{}) do
    {:ok, flight} =
      attrs
      |> Enum.into(%{})
      |> Aerotransit.Flights.create_flight()

    flight
  end

  @doc """
  Generate a flight_cargo.
  """
  def flight_cargo_fixture(attrs \\ %{}) do
    {:ok, flight_cargo} =
      attrs
      |> Enum.into(%{})
      |> Aerotransit.Flights.create_flight_cargo()

    flight_cargo
  end

  @doc """
  Generate a flight_passengers.
  """
  def flight_passengers_fixture(attrs \\ %{}) do
    {:ok, flight_passengers} =
      attrs
      |> Enum.into(%{})
      |> Aerotransit.Flights.create_flight_passengers()

    flight_passengers
  end
end
