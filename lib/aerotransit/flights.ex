defmodule Aerotransit.Flights do
  @moduledoc """
  The Flights context.
  """

  import Ecto.Query, warn: false
  alias Aerotransit.Repo

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  alias Aerotransit.Flights.CargoType

  @doc """
  Returns the list of cargo_types.

  ## Examples

      iex> list_cargo_types()
      [%CargoType{}, ...]

  """
  def list_cargo_types do
    Repo.all(CargoType)
  end

  @doc """
  Gets a single cargo_type.

  Raises `Ecto.NoResultsError` if the Cargo type does not exist.

  ## Examples

      iex> get_cargo_type!(123)
      %CargoType{}

      iex> get_cargo_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cargo_type!(id), do: Repo.get!(CargoType, id)

  @doc """
  Creates a cargo_type.

  ## Examples

      iex> create_cargo_type(%{field: value})
      {:ok, %CargoType{}}

      iex> create_cargo_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cargo_type(attrs \\ %{}) do
    %CargoType{}
    |> CargoType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cargo_type.

  ## Examples

      iex> update_cargo_type(cargo_type, %{field: new_value})
      {:ok, %CargoType{}}

      iex> update_cargo_type(cargo_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cargo_type(%CargoType{} = cargo_type, attrs) do
    cargo_type
    |> CargoType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cargo_type.

  ## Examples

      iex> delete_cargo_type(cargo_type)
      {:ok, %CargoType{}}

      iex> delete_cargo_type(cargo_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cargo_type(%CargoType{} = cargo_type) do
    Repo.delete(cargo_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cargo_type changes.

  ## Examples

      iex> change_cargo_type(cargo_type)
      %Ecto.Changeset{data: %CargoType{}}

  """
  def change_cargo_type(%CargoType{} = cargo_type, attrs \\ %{}) do
    CargoType.changeset(cargo_type, attrs)
  end

  alias Aerotransit.Flights.Cargo

  @doc """
  Returns the list of cargo.

  ## Examples

      iex> list_cargo()
      [%Cargo{}, ...]

  """
  def list_cargo do
    Repo.all(Cargo)
  end

  @doc """
  Gets a single cargo.

  Raises `Ecto.NoResultsError` if the Cargo does not exist.

  ## Examples

      iex> get_cargo!(123)
      %Cargo{}

      iex> get_cargo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cargo!(id), do: Repo.get!(Cargo, id)

  @doc """
  Creates a cargo.

  ## Examples

      iex> create_cargo(%{field: value})
      {:ok, %Cargo{}}

      iex> create_cargo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cargo(attrs \\ %{}) do
    %Cargo{}
    |> Cargo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cargo.

  ## Examples

      iex> update_cargo(cargo, %{field: new_value})
      {:ok, %Cargo{}}

      iex> update_cargo(cargo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cargo(%Cargo{} = cargo, attrs) do
    cargo
    |> Cargo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cargo.

  ## Examples

      iex> delete_cargo(cargo)
      {:ok, %Cargo{}}

      iex> delete_cargo(cargo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cargo(%Cargo{} = cargo) do
    Repo.delete(cargo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cargo changes.

  ## Examples

      iex> change_cargo(cargo)
      %Ecto.Changeset{data: %Cargo{}}

  """
  def change_cargo(%Cargo{} = cargo, attrs \\ %{}) do
    Cargo.changeset(cargo, attrs)
  end

  alias Aerotransit.Flights.Route

  @doc """
  Returns the list of routes.

  ## Examples

      iex> list_routes()
      [%Route{}, ...]

  """
  def list_routes do
    Repo.all(Route)
  end

  @doc """
  Gets a single route.

  Raises `Ecto.NoResultsError` if the Route does not exist.

  ## Examples

      iex> get_route!(123)
      %Route{}

      iex> get_route!(456)
      ** (Ecto.NoResultsError)

  """
  def get_route!(id), do: Repo.get!(Route, id)

  @doc """
  Creates a route.

  ## Examples

      iex> create_route(%{field: value})
      {:ok, %Route{}}

      iex> create_route(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_route(attrs \\ %{}) do
    %Route{}
    |> Route.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a route.

  ## Examples

      iex> update_route(route, %{field: new_value})
      {:ok, %Route{}}

      iex> update_route(route, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_route(%Route{} = route, attrs) do
    route
    |> Route.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a route.

  ## Examples

      iex> delete_route(route)
      {:ok, %Route{}}

      iex> delete_route(route)
      {:error, %Ecto.Changeset{}}

  """
  def delete_route(%Route{} = route) do
    Repo.delete(route)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking route changes.

  ## Examples

      iex> change_route(route)
      %Ecto.Changeset{data: %Route{}}

  """
  def change_route(%Route{} = route, attrs \\ %{}) do
    Route.changeset(route, attrs)
  end

  alias Aerotransit.Flights.Schedule

  @doc """
  Returns the list of schedules.

  ## Examples

      iex> list_schedules()
      [%Schedule{}, ...]

  """
  def list_schedules do
    Repo.all(Schedule)
  end

  @doc """
  Gets a single schedule.

  Raises `Ecto.NoResultsError` if the Schedule does not exist.

  ## Examples

      iex> get_schedule!(123)
      %Schedule{}

      iex> get_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_schedule!(id), do: Repo.get!(Schedule, id)

  @doc """
  Creates a schedule.

  ## Examples

      iex> create_schedule(%{field: value})
      {:ok, %Schedule{}}

      iex> create_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_schedule(attrs \\ %{}) do
    %Schedule{}
    |> Schedule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a schedule.

  ## Examples

      iex> update_schedule(schedule, %{field: new_value})
      {:ok, %Schedule{}}

      iex> update_schedule(schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_schedule(%Schedule{} = schedule, attrs) do
    schedule
    |> Schedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a schedule.

  ## Examples

      iex> delete_schedule(schedule)
      {:ok, %Schedule{}}

      iex> delete_schedule(schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_schedule(%Schedule{} = schedule) do
    Repo.delete(schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking schedule changes.

  ## Examples

      iex> change_schedule(schedule)
      %Ecto.Changeset{data: %Schedule{}}

  """
  def change_schedule(%Schedule{} = schedule, attrs \\ %{}) do
    Schedule.changeset(schedule, attrs)
  end

  alias Aerotransit.Flights.Flight

  @doc """
  Returns the list of flights.

  ## Examples

      iex> list_flights()
      [%Flight{}, ...]

  """
  def list_flights do
    Repo.all(Flight)
  end

  @doc """
  Gets a single flight.

  Raises `Ecto.NoResultsError` if the Flight does not exist.

  ## Examples

      iex> get_flight!(123)
      %Flight{}

      iex> get_flight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flight!(id), do: Repo.get!(Flight, id)

  @doc """
  Creates a flight.

  ## Examples

      iex> create_flight(%{field: value})
      {:ok, %Flight{}}

      iex> create_flight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flight(attrs \\ %{}) do
    %Flight{}
    |> Flight.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flight.

  ## Examples

      iex> update_flight(flight, %{field: new_value})
      {:ok, %Flight{}}

      iex> update_flight(flight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flight(%Flight{} = flight, attrs) do
    flight
    |> Flight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a flight.

  ## Examples

      iex> delete_flight(flight)
      {:ok, %Flight{}}

      iex> delete_flight(flight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flight(%Flight{} = flight) do
    Repo.delete(flight)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flight changes.

  ## Examples

      iex> change_flight(flight)
      %Ecto.Changeset{data: %Flight{}}

  """
  def change_flight(%Flight{} = flight, attrs \\ %{}) do
    Flight.changeset(flight, attrs)
  end

  alias Aerotransit.Flights.FlightCargo

  @doc """
  Returns the list of flight_cargo.

  ## Examples

      iex> list_flight_cargo()
      [%FlightCargo{}, ...]

  """
  def list_flight_cargo do
    Repo.all(FlightCargo)
  end

  @doc """
  Gets a single flight_cargo.

  Raises `Ecto.NoResultsError` if the Flight cargo does not exist.

  ## Examples

      iex> get_flight_cargo!(123)
      %FlightCargo{}

      iex> get_flight_cargo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flight_cargo!(id), do: Repo.get!(FlightCargo, id)

  @doc """
  Creates a flight_cargo.

  ## Examples

      iex> create_flight_cargo(%{field: value})
      {:ok, %FlightCargo{}}

      iex> create_flight_cargo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flight_cargo(attrs \\ %{}) do
    %FlightCargo{}
    |> FlightCargo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flight_cargo.

  ## Examples

      iex> update_flight_cargo(flight_cargo, %{field: new_value})
      {:ok, %FlightCargo{}}

      iex> update_flight_cargo(flight_cargo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flight_cargo(%FlightCargo{} = flight_cargo, attrs) do
    flight_cargo
    |> FlightCargo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a flight_cargo.

  ## Examples

      iex> delete_flight_cargo(flight_cargo)
      {:ok, %FlightCargo{}}

      iex> delete_flight_cargo(flight_cargo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flight_cargo(%FlightCargo{} = flight_cargo) do
    Repo.delete(flight_cargo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flight_cargo changes.

  ## Examples

      iex> change_flight_cargo(flight_cargo)
      %Ecto.Changeset{data: %FlightCargo{}}

  """
  def change_flight_cargo(%FlightCargo{} = flight_cargo, attrs \\ %{}) do
    FlightCargo.changeset(flight_cargo, attrs)
  end

  alias Aerotransit.Flights.FlightPassengers

  @doc """
  Returns the list of flight_passengers.

  ## Examples

      iex> list_flight_passengers()
      [%FlightPassengers{}, ...]

  """
  def list_flight_passengers do
    Repo.all(FlightPassengers)
  end

  @doc """
  Gets a single flight_passengers.

  Raises `Ecto.NoResultsError` if the Flight passengers does not exist.

  ## Examples

      iex> get_flight_passengers!(123)
      %FlightPassengers{}

      iex> get_flight_passengers!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flight_passengers!(id), do: Repo.get!(FlightPassengers, id)

  @doc """
  Creates a flight_passengers.

  ## Examples

      iex> create_flight_passengers(%{field: value})
      {:ok, %FlightPassengers{}}

      iex> create_flight_passengers(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flight_passengers(attrs \\ %{}) do
    %FlightPassengers{}
    |> FlightPassengers.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flight_passengers.

  ## Examples

      iex> update_flight_passengers(flight_passengers, %{field: new_value})
      {:ok, %FlightPassengers{}}

      iex> update_flight_passengers(flight_passengers, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flight_passengers(%FlightPassengers{} = flight_passengers, attrs) do
    flight_passengers
    |> FlightPassengers.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a flight_passengers.

  ## Examples

      iex> delete_flight_passengers(flight_passengers)
      {:ok, %FlightPassengers{}}

      iex> delete_flight_passengers(flight_passengers)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flight_passengers(%FlightPassengers{} = flight_passengers) do
    Repo.delete(flight_passengers)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flight_passengers changes.

  ## Examples

      iex> change_flight_passengers(flight_passengers)
      %Ecto.Changeset{data: %FlightPassengers{}}

  """
  def change_flight_passengers(%FlightPassengers{} = flight_passengers, attrs \\ %{}) do
    FlightPassengers.changeset(flight_passengers, attrs)
  end
end
