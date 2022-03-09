defmodule Aerotransit.Knowledge do
  @moduledoc """
  The Knowledge context.
  """

  import Ecto.Query, warn: false
  alias Aerotransit.Repo

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  alias Aerotransit.Knowledge.Country

  @doc """
  Returns the list of countries.

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  def list_countries do
    Repo.all(Country)
  end

  @doc """
  Gets a single country.

  Raises `Ecto.NoResultsError` if the Country does not exist.

  ## Examples

      iex> get_country!(123)
      %Country{}

      iex> get_country!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country!(id), do: Repo.get!(Country, id)

  def get_country(id) do
    case(Repo.get(Country, id)) do
      nil -> {:error, "Not found"}
      data -> {:ok, data}
    end
  end

  @doc """
  Creates a country.

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country.

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a country.

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country(%Country{} = country) do
    Repo.delete(country)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{data: %Country{}}

  """
  def change_country(%Country{} = country, attrs \\ %{}) do
    Country.changeset(country, attrs)
  end

  alias Aerotransit.Knowledge.Passenger

  @doc """
  Returns the list of passengers.

  ## Examples

      iex> list_passengers()
      [%Passenger{}, ...]

  """
  def list_passengers do
    Repo.all(Passenger)
  end

  @doc """
  Gets a single passenger.

  Raises `Ecto.NoResultsError` if the Passenger does not exist.

  ## Examples

      iex> get_passenger!(123)
      %Passenger{}

      iex> get_passenger!(456)
      ** (Ecto.NoResultsError)

  """
  def get_passenger!(id), do: Repo.get!(Passenger, id)

  def get_passenger(id) do
    case(Repo.get(Passenger, id)) do
      nil -> {:error, "Not found"}
      data -> {:ok, data}
    end
  end

  @doc """
  Creates a passenger.

  ## Examples

      iex> create_passenger(%{field: value})
      {:ok, %Passenger{}}

      iex> create_passenger(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_passenger(attrs \\ %{}) do
    %Passenger{}
    |> Passenger.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a passenger.

  ## Examples

      iex> update_passenger(passenger, %{field: new_value})
      {:ok, %Passenger{}}

      iex> update_passenger(passenger, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_passenger(%Passenger{} = passenger, attrs) do
    passenger
    |> Passenger.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a passenger.

  ## Examples

      iex> delete_passenger(passenger)
      {:ok, %Passenger{}}

      iex> delete_passenger(passenger)
      {:error, %Ecto.Changeset{}}

  """
  def delete_passenger(%Passenger{} = passenger) do
    Repo.delete(passenger)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking passenger changes.

  ## Examples

      iex> change_passenger(passenger)
      %Ecto.Changeset{data: %Passenger{}}

  """
  def change_passenger(%Passenger{} = passenger, attrs \\ %{}) do
    Passenger.changeset(passenger, attrs)
  end

  alias Aerotransit.Knowledge.Company

  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id), do: Repo.get!(Company, id)

  def get_company(id) do
    case(Repo.get(Company, id)) do
      nil -> {:error, "Not found"}
      data -> {:ok, data}
    end
  end

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{data: %Company{}}

  """
  def change_company(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end

  alias Aerotransit.Knowledge.Airport

  @doc """
  Returns the list of airports.

  ## Examples

      iex> list_airports()
      [%Airport{}, ...]

  """
  def list_airports do
    Repo.all(Airport)
  end

  @doc """
  Gets a single airport.

  Raises `Ecto.NoResultsError` if the Airport does not exist.

  ## Examples

      iex> get_airport!(123)
      %Airport{}

      iex> get_airport!(456)
      ** (Ecto.NoResultsError)

  """
  def get_airport!(id), do: Repo.get!(Airport, id)

  def get_airport(id) do
    case(Repo.get(Airport, id)) do
      nil -> {:error, "Not found"}
      data -> {:ok, data}
    end
  end

  @doc """
  Creates a airport.

  ## Examples

      iex> create_airport(%{field: value})
      {:ok, %Airport{}}

      iex> create_airport(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_airport(attrs \\ %{}) do
    %Airport{}
    |> Airport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a airport.

  ## Examples

      iex> update_airport(airport, %{field: new_value})
      {:ok, %Airport{}}

      iex> update_airport(airport, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_airport(%Airport{} = airport, attrs) do
    airport
    |> Airport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a airport.

  ## Examples

      iex> delete_airport(airport)
      {:ok, %Airport{}}

      iex> delete_airport(airport)
      {:error, %Ecto.Changeset{}}

  """
  def delete_airport(%Airport{} = airport) do
    Repo.delete(airport)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking airport changes.

  ## Examples

      iex> change_airport(airport)
      %Ecto.Changeset{data: %Airport{}}

  """
  def change_airport(%Airport{} = airport, attrs \\ %{}) do
    Airport.changeset(airport, attrs)
  end

  alias Aerotransit.Knowledge.PlaneType

  @doc """
  Returns the list of plane_types.

  ## Examples

      iex> list_plane_types()
      [%PlaneType{}, ...]

  """
  def list_plane_types do
    Repo.all(PlaneType)
  end

  @doc """
  Gets a single plane_type.

  Raises `Ecto.NoResultsError` if the Plane type does not exist.

  ## Examples

      iex> get_plane_type!(123)
      %PlaneType{}

      iex> get_plane_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plane_type!(id), do: Repo.get!(PlaneType, id)

  def get_plane_type(id) do
    case(Repo.get(PlaneType, id)) do
      nil -> {:error, "Not found"}
      data -> {:ok, data}
    end
  end

  @doc """
  Creates a plane_type.

  ## Examples

      iex> create_plane_type(%{field: value})
      {:ok, %PlaneType{}}

      iex> create_plane_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plane_type(attrs \\ %{}) do
    %PlaneType{}
    |> PlaneType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plane_type.

  ## Examples

      iex> update_plane_type(plane_type, %{field: new_value})
      {:ok, %PlaneType{}}

      iex> update_plane_type(plane_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plane_type(%PlaneType{} = plane_type, attrs) do
    plane_type
    |> PlaneType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plane_type.

  ## Examples

      iex> delete_plane_type(plane_type)
      {:ok, %PlaneType{}}

      iex> delete_plane_type(plane_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plane_type(%PlaneType{} = plane_type) do
    Repo.delete(plane_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plane_type changes.

  ## Examples

      iex> change_plane_type(plane_type)
      %Ecto.Changeset{data: %PlaneType{}}

  """
  def change_plane_type(%PlaneType{} = plane_type, attrs \\ %{}) do
    PlaneType.changeset(plane_type, attrs)
  end

  alias Aerotransit.Knowledge.Plane

  @doc """
  Returns the list of planes.

  ## Examples

      iex> list_planes()
      [%Plane{}, ...]

  """
  def list_planes do
    Repo.all(Plane)
  end

  @doc """
  Gets a single plane.

  Raises `Ecto.NoResultsError` if the Plane does not exist.

  ## Examples

      iex> get_plane!(123)
      %Plane{}

      iex> get_plane!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plane!(id), do: Repo.get!(Plane, id)

  def get_plane(id) do
    case(Repo.get(Plane, id)) do
      nil -> {:error, "Not found"}
      data -> {:ok, data}
    end
  end

  @doc """
  Creates a plane.

  ## Examples

      iex> create_plane(%{field: value})
      {:ok, %Plane{}}

      iex> create_plane(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plane(attrs \\ %{}) do
    %Plane{}
    |> Plane.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plane.

  ## Examples

      iex> update_plane(plane, %{field: new_value})
      {:ok, %Plane{}}

      iex> update_plane(plane, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plane(%Plane{} = plane, attrs) do
    plane
    |> Plane.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plane.

  ## Examples

      iex> delete_plane(plane)
      {:ok, %Plane{}}

      iex> delete_plane(plane)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plane(%Plane{} = plane) do
    Repo.delete(plane)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plane changes.

  ## Examples

      iex> change_plane(plane)
      %Ecto.Changeset{data: %Plane{}}

  """
  def change_plane(%Plane{} = plane, attrs \\ %{}) do
    Plane.changeset(plane, attrs)
  end
end
