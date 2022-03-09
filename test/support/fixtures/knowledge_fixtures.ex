defmodule Aerotransit.KnowledgeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Aerotransit.Knowledge` context.
  """

  @doc """
  Generate a airport.
  """
  def airport_fixture(attrs \\ %{}) do
    {:ok, airport} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Aerotransit.Knowledge.create_airport()

    airport
  end

  @doc """
  Generate a unique plane_type name.
  """
  def unique_plane_type_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a plane_type.
  """
  def plane_type_fixture(attrs \\ %{}) do
    {:ok, plane_type} =
      attrs
      |> Enum.into(%{
        name: unique_plane_type_name()
      })
      |> Aerotransit.Knowledge.create_plane_type()

    plane_type
  end

  @doc """
  Generate a unique plane code.
  """
  def unique_plane_code, do: "some code#{System.unique_integer([:positive])}"

  @doc """
  Generate a plane.
  """
  def plane_fixture(attrs \\ %{}) do
    {:ok, plane} =
      attrs
      |> Enum.into(%{
        code: unique_plane_code()
      })
      |> Aerotransit.Knowledge.create_plane()

    plane
  end
end
