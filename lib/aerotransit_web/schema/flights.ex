defmodule AerotransitWeb.Schema.Flights do
  @moduledoc false

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias Aerotransit.{Repo, Generic, Knowledge, Flights}

  # import_types(AerotransitWeb.Schema.Knowledge)

  object :cargo_type do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :cargo, :cargo |> non_null |> list_of |> non_null, resolve: dataloader(Flights)
  end

  object :cargo do
    field :id, non_null(:id)
    field :weight, non_null(:integer)
    field :type, non_null(:cargo_type), resolve: dataloader(Flights)
    field :company, non_null(:company), resolve: dataloader(Knowledge)
    field :flights, :flight |> non_null |> list_of |> non_null, resolve: dataloader(Flights)
  end

  object :route do
    field :id, non_null(:id)
    field :duration, non_null(:integer)
    field :from, non_null(:airport), resolve: dataloader(Knowledge)
    field :to, non_null(:airport), resolve: dataloader(Knowledge)
    field :schedules, :schedule |> non_null |> list_of |> non_null, resolve: dataloader(Flights)
    field :flights, :flight |> non_null |> list_of |> non_null, resolve: dataloader(Flights)
  end

  object :schedule do
    field :id, non_null(:id)
    field :day, non_null(:integer)
    field :start, non_null(:time)
    field :route, non_null(:route), resolve: dataloader(Flights)
  end

  object :flight do
    field :id, non_null(:id)
    field :plane, non_null(:plane), resolve: dataloader(Knowledge)
    field :route, non_null(:route), resolve: dataloader(Flights)
    field :shedule, :schedule, resolve: dataloader(Flights)

    field :passengers, :passenger |> non_null |> list_of |> non_null,
      resolve: dataloader(Knowledge)

    field :cargo, :cargo |> non_null |> list_of |> non_null, resolve: dataloader(Flights)
  end

  object :flights_queries do
    field :cargo_types, :cargo_type |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&cargo_types_resolve/2)
    end

    field :cargos, :cargo |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&cargos_resolve/2)
    end

    field :routes, :route |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&routes_resolve/2)
    end

    field :flights, :flight |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&flights_resolve/2)
    end
  end

  object :flights_mutations do
    field :create_flight, non_null(:flight) do
      arg(:plane_id, non_null(:id))
      arg(:route_id, non_null(:id))

      resolve(fn args, _ -> Flights.create_flight(args) end)
    end

    field :create_cargo, non_null(:cargo) do
      arg(:weight, non_null(:integer))
      arg(:type_id, non_null(:id))
      arg(:company_id, non_null(:id))

      resolve(fn args, _ -> Flights.create_cargo(args) end)
    end

    field :add_cargo_to_flight, non_null(:flight) do
      arg(:id, non_null(:id))
      arg(:cargo_id, non_null(:id))

      resolve(fn %{id: id, cargo_id: cargo_id}, _ ->
        try do
          flight = Flights.get_flight!(id)
          cargo = Flights.get_cargo!(cargo_id)

          flight
          |> Repo.preload(:cargo)
          |> Ecto.Changeset.change()
          |> Ecto.Changeset.put_assoc(:cargo, [cargo])
          |> Repo.update()
        catch
          _ -> {:error, "Error"}
        end
      end)
    end

    field :add_passenger_to_flight, non_null(:flight) do
      arg(:id, non_null(:id))
      arg(:passenger_id, non_null(:id))

      resolve(fn %{id: id, passenger_id: passenger_id}, _ ->
        try do
          flight = Flights.get_flight!(id)
          passenger = Knowledge.get_passenger!(passenger_id)

          flight
          |> Repo.preload(:passengers)
          |> Ecto.Changeset.change()
          |> Ecto.Changeset.put_assoc(:passengers, [passenger])
          |> Repo.update()
        catch
          _ -> {:error, "Error"}
        end
      end)
    end
  end

  def cargo_types_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Flights.CargoType, args)
     |> Repo.all()}
  end

  def cargo_types_resolve(_, _) do
    {:ok, Flights.list_cargo_types()}
  end

  def cargos_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Flights.Cargo, args)
     |> Repo.all()}
  end

  def cargos_resolve(_, _) do
    {:ok, Flights.list_cargo()}
  end

  def routes_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Flights.Route, args)
     |> Repo.all()}
  end

  def routes_resolve(_, _) do
    {:ok, Flights.list_routes()}
  end

  def flights_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Flights.Flight, args)
     |> Repo.all()}
  end

  def flights_resolve(_, _) do
    {:ok, Flights.list_flights()}
  end
end
