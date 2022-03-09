defmodule Aerotransit.FlightsTest do
  use Aerotransit.DataCase

  alias Aerotransit.Flights

  describe "cargo_types" do
    alias Aerotransit.Flights.CargoType

    import Aerotransit.FlightsFixtures

    @invalid_attrs %{name: nil}

    test "list_cargo_types/0 returns all cargo_types" do
      cargo_type = cargo_type_fixture()
      assert Flights.list_cargo_types() == [cargo_type]
    end

    test "get_cargo_type!/1 returns the cargo_type with given id" do
      cargo_type = cargo_type_fixture()
      assert Flights.get_cargo_type!(cargo_type.id) == cargo_type
    end

    test "create_cargo_type/1 with valid data creates a cargo_type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %CargoType{} = cargo_type} = Flights.create_cargo_type(valid_attrs)
      assert cargo_type.name == "some name"
    end

    test "create_cargo_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_cargo_type(@invalid_attrs)
    end

    test "update_cargo_type/2 with valid data updates the cargo_type" do
      cargo_type = cargo_type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %CargoType{} = cargo_type} =
               Flights.update_cargo_type(cargo_type, update_attrs)

      assert cargo_type.name == "some updated name"
    end

    test "update_cargo_type/2 with invalid data returns error changeset" do
      cargo_type = cargo_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_cargo_type(cargo_type, @invalid_attrs)
      assert cargo_type == Flights.get_cargo_type!(cargo_type.id)
    end

    test "delete_cargo_type/1 deletes the cargo_type" do
      cargo_type = cargo_type_fixture()
      assert {:ok, %CargoType{}} = Flights.delete_cargo_type(cargo_type)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_cargo_type!(cargo_type.id) end
    end

    test "change_cargo_type/1 returns a cargo_type changeset" do
      cargo_type = cargo_type_fixture()
      assert %Ecto.Changeset{} = Flights.change_cargo_type(cargo_type)
    end
  end

  describe "cargo" do
    alias Aerotransit.Flights.Cargo

    import Aerotransit.FlightsFixtures

    @invalid_attrs %{weight: nil}

    test "list_cargo/0 returns all cargo" do
      cargo = cargo_fixture()
      assert Flights.list_cargo() == [cargo]
    end

    test "get_cargo!/1 returns the cargo with given id" do
      cargo = cargo_fixture()
      assert Flights.get_cargo!(cargo.id) == cargo
    end

    test "create_cargo/1 with valid data creates a cargo" do
      valid_attrs = %{weight: 42}

      assert {:ok, %Cargo{} = cargo} = Flights.create_cargo(valid_attrs)
      assert cargo.weight == 42
    end

    test "create_cargo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_cargo(@invalid_attrs)
    end

    test "update_cargo/2 with valid data updates the cargo" do
      cargo = cargo_fixture()
      update_attrs = %{weight: 43}

      assert {:ok, %Cargo{} = cargo} = Flights.update_cargo(cargo, update_attrs)
      assert cargo.weight == 43
    end

    test "update_cargo/2 with invalid data returns error changeset" do
      cargo = cargo_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_cargo(cargo, @invalid_attrs)
      assert cargo == Flights.get_cargo!(cargo.id)
    end

    test "delete_cargo/1 deletes the cargo" do
      cargo = cargo_fixture()
      assert {:ok, %Cargo{}} = Flights.delete_cargo(cargo)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_cargo!(cargo.id) end
    end

    test "change_cargo/1 returns a cargo changeset" do
      cargo = cargo_fixture()
      assert %Ecto.Changeset{} = Flights.change_cargo(cargo)
    end
  end

  describe "routes" do
    alias Aerotransit.Flights.Route

    import Aerotransit.FlightsFixtures

    @invalid_attrs %{duration: nil}

    test "list_routes/0 returns all routes" do
      route = route_fixture()
      assert Flights.list_routes() == [route]
    end

    test "get_route!/1 returns the route with given id" do
      route = route_fixture()
      assert Flights.get_route!(route.id) == route
    end

    test "create_route/1 with valid data creates a route" do
      valid_attrs = %{duration: 42}

      assert {:ok, %Route{} = route} = Flights.create_route(valid_attrs)
      assert route.duration == 42
    end

    test "create_route/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_route(@invalid_attrs)
    end

    test "update_route/2 with valid data updates the route" do
      route = route_fixture()
      update_attrs = %{duration: 43}

      assert {:ok, %Route{} = route} = Flights.update_route(route, update_attrs)
      assert route.duration == 43
    end

    test "update_route/2 with invalid data returns error changeset" do
      route = route_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_route(route, @invalid_attrs)
      assert route == Flights.get_route!(route.id)
    end

    test "delete_route/1 deletes the route" do
      route = route_fixture()
      assert {:ok, %Route{}} = Flights.delete_route(route)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_route!(route.id) end
    end

    test "change_route/1 returns a route changeset" do
      route = route_fixture()
      assert %Ecto.Changeset{} = Flights.change_route(route)
    end
  end

  describe "schedules" do
    alias Aerotransit.Flights.Schedule

    import Aerotransit.FlightsFixtures

    @invalid_attrs %{day: nil, start: nil}

    test "list_schedules/0 returns all schedules" do
      schedule = schedule_fixture()
      assert Flights.list_schedules() == [schedule]
    end

    test "get_schedule!/1 returns the schedule with given id" do
      schedule = schedule_fixture()
      assert Flights.get_schedule!(schedule.id) == schedule
    end

    test "create_schedule/1 with valid data creates a schedule" do
      valid_attrs = %{day: 42, start: ~T[14:00:00]}

      assert {:ok, %Schedule{} = schedule} = Flights.create_schedule(valid_attrs)
      assert schedule.day == 42
      assert schedule.start == ~T[14:00:00]
    end

    test "create_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_schedule(@invalid_attrs)
    end

    test "update_schedule/2 with valid data updates the schedule" do
      schedule = schedule_fixture()
      update_attrs = %{day: 43, start: ~T[15:01:01]}

      assert {:ok, %Schedule{} = schedule} = Flights.update_schedule(schedule, update_attrs)
      assert schedule.day == 43
      assert schedule.start == ~T[15:01:01]
    end

    test "update_schedule/2 with invalid data returns error changeset" do
      schedule = schedule_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_schedule(schedule, @invalid_attrs)
      assert schedule == Flights.get_schedule!(schedule.id)
    end

    test "delete_schedule/1 deletes the schedule" do
      schedule = schedule_fixture()
      assert {:ok, %Schedule{}} = Flights.delete_schedule(schedule)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_schedule!(schedule.id) end
    end

    test "change_schedule/1 returns a schedule changeset" do
      schedule = schedule_fixture()
      assert %Ecto.Changeset{} = Flights.change_schedule(schedule)
    end
  end

  describe "flights" do
    alias Aerotransit.Flights.Flight

    import Aerotransit.FlightsFixtures

    @invalid_attrs %{}

    test "list_flights/0 returns all flights" do
      flight = flight_fixture()
      assert Flights.list_flights() == [flight]
    end

    test "get_flight!/1 returns the flight with given id" do
      flight = flight_fixture()
      assert Flights.get_flight!(flight.id) == flight
    end

    test "create_flight/1 with valid data creates a flight" do
      valid_attrs = %{}

      assert {:ok, %Flight{} = flight} = Flights.create_flight(valid_attrs)
    end

    test "create_flight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_flight(@invalid_attrs)
    end

    test "update_flight/2 with valid data updates the flight" do
      flight = flight_fixture()
      update_attrs = %{}

      assert {:ok, %Flight{} = flight} = Flights.update_flight(flight, update_attrs)
    end

    test "update_flight/2 with invalid data returns error changeset" do
      flight = flight_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_flight(flight, @invalid_attrs)
      assert flight == Flights.get_flight!(flight.id)
    end

    test "delete_flight/1 deletes the flight" do
      flight = flight_fixture()
      assert {:ok, %Flight{}} = Flights.delete_flight(flight)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_flight!(flight.id) end
    end

    test "change_flight/1 returns a flight changeset" do
      flight = flight_fixture()
      assert %Ecto.Changeset{} = Flights.change_flight(flight)
    end
  end

  describe "flight_cargo" do
    alias Aerotransit.Flights.FlightCargo

    import Aerotransit.FlightsFixtures

    @invalid_attrs %{}

    test "list_flight_cargo/0 returns all flight_cargo" do
      flight_cargo = flight_cargo_fixture()
      assert Flights.list_flight_cargo() == [flight_cargo]
    end

    test "get_flight_cargo!/1 returns the flight_cargo with given id" do
      flight_cargo = flight_cargo_fixture()
      assert Flights.get_flight_cargo!(flight_cargo.id) == flight_cargo
    end

    test "create_flight_cargo/1 with valid data creates a flight_cargo" do
      valid_attrs = %{}

      assert {:ok, %FlightCargo{} = flight_cargo} = Flights.create_flight_cargo(valid_attrs)
    end

    test "create_flight_cargo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_flight_cargo(@invalid_attrs)
    end

    test "update_flight_cargo/2 with valid data updates the flight_cargo" do
      flight_cargo = flight_cargo_fixture()
      update_attrs = %{}

      assert {:ok, %FlightCargo{} = flight_cargo} =
               Flights.update_flight_cargo(flight_cargo, update_attrs)
    end

    test "update_flight_cargo/2 with invalid data returns error changeset" do
      flight_cargo = flight_cargo_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Flights.update_flight_cargo(flight_cargo, @invalid_attrs)

      assert flight_cargo == Flights.get_flight_cargo!(flight_cargo.id)
    end

    test "delete_flight_cargo/1 deletes the flight_cargo" do
      flight_cargo = flight_cargo_fixture()
      assert {:ok, %FlightCargo{}} = Flights.delete_flight_cargo(flight_cargo)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_flight_cargo!(flight_cargo.id) end
    end

    test "change_flight_cargo/1 returns a flight_cargo changeset" do
      flight_cargo = flight_cargo_fixture()
      assert %Ecto.Changeset{} = Flights.change_flight_cargo(flight_cargo)
    end
  end

  describe "flight_passengers" do
    alias Aerotransit.Flights.FlightPassengers

    import Aerotransit.FlightsFixtures

    @invalid_attrs %{}

    test "list_flight_passengers/0 returns all flight_passengers" do
      flight_passengers = flight_passengers_fixture()
      assert Flights.list_flight_passengers() == [flight_passengers]
    end

    test "get_flight_passengers!/1 returns the flight_passengers with given id" do
      flight_passengers = flight_passengers_fixture()
      assert Flights.get_flight_passengers!(flight_passengers.id) == flight_passengers
    end

    test "create_flight_passengers/1 with valid data creates a flight_passengers" do
      valid_attrs = %{}

      assert {:ok, %FlightPassengers{} = flight_passengers} =
               Flights.create_flight_passengers(valid_attrs)
    end

    test "create_flight_passengers/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_flight_passengers(@invalid_attrs)
    end

    test "update_flight_passengers/2 with valid data updates the flight_passengers" do
      flight_passengers = flight_passengers_fixture()
      update_attrs = %{}

      assert {:ok, %FlightPassengers{} = flight_passengers} =
               Flights.update_flight_passengers(flight_passengers, update_attrs)
    end

    test "update_flight_passengers/2 with invalid data returns error changeset" do
      flight_passengers = flight_passengers_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Flights.update_flight_passengers(flight_passengers, @invalid_attrs)

      assert flight_passengers == Flights.get_flight_passengers!(flight_passengers.id)
    end

    test "delete_flight_passengers/1 deletes the flight_passengers" do
      flight_passengers = flight_passengers_fixture()
      assert {:ok, %FlightPassengers{}} = Flights.delete_flight_passengers(flight_passengers)

      assert_raise Ecto.NoResultsError, fn ->
        Flights.get_flight_passengers!(flight_passengers.id)
      end
    end

    test "change_flight_passengers/1 returns a flight_passengers changeset" do
      flight_passengers = flight_passengers_fixture()
      assert %Ecto.Changeset{} = Flights.change_flight_passengers(flight_passengers)
    end
  end
end
