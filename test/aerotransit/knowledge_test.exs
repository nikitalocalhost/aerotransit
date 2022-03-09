defmodule Aerotransit.KnowledgeTest do
  use Aerotransit.DataCase

  alias Aerotransit.Knowledge

  describe "airports" do
    alias Aerotransit.Knowledge.Airport

    import Aerotransit.KnowledgeFixtures

    @invalid_attrs %{name: nil}

    test "list_airports/0 returns all airports" do
      airport = airport_fixture()
      assert Knowledge.list_airports() == [airport]
    end

    test "get_airport!/1 returns the airport with given id" do
      airport = airport_fixture()
      assert Knowledge.get_airport!(airport.id) == airport
    end

    test "create_airport/1 with valid data creates a airport" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Airport{} = airport} = Knowledge.create_airport(valid_attrs)
      assert airport.name == "some name"
    end

    test "create_airport/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Knowledge.create_airport(@invalid_attrs)
    end

    test "update_airport/2 with valid data updates the airport" do
      airport = airport_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Airport{} = airport} = Knowledge.update_airport(airport, update_attrs)
      assert airport.name == "some updated name"
    end

    test "update_airport/2 with invalid data returns error changeset" do
      airport = airport_fixture()
      assert {:error, %Ecto.Changeset{}} = Knowledge.update_airport(airport, @invalid_attrs)
      assert airport == Knowledge.get_airport!(airport.id)
    end

    test "delete_airport/1 deletes the airport" do
      airport = airport_fixture()
      assert {:ok, %Airport{}} = Knowledge.delete_airport(airport)
      assert_raise Ecto.NoResultsError, fn -> Knowledge.get_airport!(airport.id) end
    end

    test "change_airport/1 returns a airport changeset" do
      airport = airport_fixture()
      assert %Ecto.Changeset{} = Knowledge.change_airport(airport)
    end
  end

  describe "plane_types" do
    alias Aerotransit.Knowledge.PlaneType

    import Aerotransit.KnowledgeFixtures

    @invalid_attrs %{name: nil}

    test "list_plane_types/0 returns all plane_types" do
      plane_type = plane_type_fixture()
      assert Knowledge.list_plane_types() == [plane_type]
    end

    test "get_plane_type!/1 returns the plane_type with given id" do
      plane_type = plane_type_fixture()
      assert Knowledge.get_plane_type!(plane_type.id) == plane_type
    end

    test "create_plane_type/1 with valid data creates a plane_type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %PlaneType{} = plane_type} = Knowledge.create_plane_type(valid_attrs)
      assert plane_type.name == "some name"
    end

    test "create_plane_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Knowledge.create_plane_type(@invalid_attrs)
    end

    test "update_plane_type/2 with valid data updates the plane_type" do
      plane_type = plane_type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %PlaneType{} = plane_type} =
               Knowledge.update_plane_type(plane_type, update_attrs)

      assert plane_type.name == "some updated name"
    end

    test "update_plane_type/2 with invalid data returns error changeset" do
      plane_type = plane_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Knowledge.update_plane_type(plane_type, @invalid_attrs)
      assert plane_type == Knowledge.get_plane_type!(plane_type.id)
    end

    test "delete_plane_type/1 deletes the plane_type" do
      plane_type = plane_type_fixture()
      assert {:ok, %PlaneType{}} = Knowledge.delete_plane_type(plane_type)
      assert_raise Ecto.NoResultsError, fn -> Knowledge.get_plane_type!(plane_type.id) end
    end

    test "change_plane_type/1 returns a plane_type changeset" do
      plane_type = plane_type_fixture()
      assert %Ecto.Changeset{} = Knowledge.change_plane_type(plane_type)
    end
  end

  describe "planes" do
    alias Aerotransit.Knowledge.Plane

    import Aerotransit.KnowledgeFixtures

    @invalid_attrs %{code: nil}

    test "list_planes/0 returns all planes" do
      plane = plane_fixture()
      assert Knowledge.list_planes() == [plane]
    end

    test "get_plane!/1 returns the plane with given id" do
      plane = plane_fixture()
      assert Knowledge.get_plane!(plane.id) == plane
    end

    test "create_plane/1 with valid data creates a plane" do
      valid_attrs = %{code: "some code"}

      assert {:ok, %Plane{} = plane} = Knowledge.create_plane(valid_attrs)
      assert plane.code == "some code"
    end

    test "create_plane/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Knowledge.create_plane(@invalid_attrs)
    end

    test "update_plane/2 with valid data updates the plane" do
      plane = plane_fixture()
      update_attrs = %{code: "some updated code"}

      assert {:ok, %Plane{} = plane} = Knowledge.update_plane(plane, update_attrs)
      assert plane.code == "some updated code"
    end

    test "update_plane/2 with invalid data returns error changeset" do
      plane = plane_fixture()
      assert {:error, %Ecto.Changeset{}} = Knowledge.update_plane(plane, @invalid_attrs)
      assert plane == Knowledge.get_plane!(plane.id)
    end

    test "delete_plane/1 deletes the plane" do
      plane = plane_fixture()
      assert {:ok, %Plane{}} = Knowledge.delete_plane(plane)
      assert_raise Ecto.NoResultsError, fn -> Knowledge.get_plane!(plane.id) end
    end

    test "change_plane/1 returns a plane changeset" do
      plane = plane_fixture()
      assert %Ecto.Changeset{} = Knowledge.change_plane(plane)
    end
  end
end
