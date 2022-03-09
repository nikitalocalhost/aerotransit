defmodule AerotransitWeb.Schema.Knowledge do
  @moduledoc false

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  import Ecto.Query
  alias Aerotransit.{Repo, Knowledge, Flights}
  alias AerotransitWeb.Schema.Generic

  # import_types(AerotransitWeb.Schema.Flights)

  object :country do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :companies, :company |> non_null |> list_of |> non_null, resolve: dataloader(Knowledge)
    field :airports, :airport |> non_null |> list_of |> non_null, resolve: dataloader(Knowledge)

    field :passengers, :passenger |> non_null |> list_of |> non_null,
      resolve: dataloader(Knowledge)
  end

  object :company do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :register, non_null(:string)
    field :government, non_null(:boolean)
    field :country, non_null(:country), resolve: dataloader(Knowledge)
    field :airports, :airport |> non_null |> list_of |> non_null, resolve: dataloader(Knowledge)
  end

  object :airport do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :country, non_null(:country), resolve: dataloader(Knowledge)
    field :owner, non_null(:company), resolve: dataloader(Knowledge)
    field :planes, :plane |> non_null |> list_of |> non_null, resolve: dataloader(Knowledge)
    field :routes_from, :route |> non_null |> list_of |> non_null, resolve: dataloader(Flights)
    field :routes_to, :route |> non_null |> list_of |> non_null, resolve: dataloader(Flights)
  end

  object :passenger do
    field :id, non_null(:id)
    field :full_name, non_null(:string)
    field :passport, non_null(:string)
    field :age, non_null(:integer)
    field :sex, non_null(:boolean)
    field :country, non_null(:country), resolve: dataloader(Knowledge)
    field :flights, :flight |> non_null |> list_of |> non_null, resolve: dataloader(Flights)
  end

  object :plane_type do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :planes, :plane |> non_null |> list_of |> non_null, resolve: dataloader(Knowledge)
  end

  object :plane do
    field :id, non_null(:id)
    field :code, non_null(:string)
    field :type, non_null(:plane_type), resolve: dataloader(Knowledge)
    field :company, non_null(:company), resolve: dataloader(Knowledge)
    field :airport, :airport, resolve: dataloader(Knowledge)
  end

  object :knowledge_queries do
    field :country, non_null(:country) do
      arg(:id, non_null(:id))
      resolve(fn %{id: id}, _ -> Knowledge.get_country(id) end)
    end

    field :countries, :country |> non_null |> list_of |> non_null do
      arg(:filter, :filter)

      resolve(&countries_resolve/2)
    end

    field :companies, :company |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&companies_resolve/2)
    end

    field :airports, :airport |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&airports_resolve/2)
    end

    field :passengers, :passenger |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&passengers_resolve/2)
    end

    field :plane_types, :plane_type |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&plane_types_resolve/2)
    end

    field :planes, :plane |> non_null |> list_of |> non_null do
      arg(:filter, :filter)
      resolve(&planes_resolve/2)
    end
  end

  object :knowledge_mutations do
    field :create_country, non_null(:country) do
      arg(:name, non_null(:string))
      resolve(fn args, _ -> Knowledge.create_country(args) end)
    end

    field :change_country, non_null(:country) do
      arg(:id, non_null(:id))
      arg(:name, non_null(:string))

      resolve(fn
        %{id: id, name: name}, _ ->
          case(Knowledge.get_country(id)) do
            {:ok, country} ->
              Knowledge.update_country(country, %{name: name})

            _ ->
              {:error, "Country with this id is not found"}
          end
      end)
    end

    field :delete_country, non_null(:boolean) do
      arg(:id, non_null(:id))

      resolve(fn
        %{id: id}, _ ->
          with {:ok, country} <- Knowledge.get_country(id),
               {:ok, _country} <- Knowledge.delete_country(country) do
            {:ok, true}
          else
            _ ->
              {:ok, false}
          end
      end)
    end

    field :create_passenger, non_null(:passenger) do
      arg(:full_name, non_null(:string))
      arg(:passport, non_null(:string))
      arg(:age, non_null(:integer))
      arg(:sex, non_null(:boolean))
      arg(:country_id, non_null(:id))

      resolve(fn args, _ -> Knowledge.create_passenger(args) end)
    end
  end

  def countries_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Knowledge.Country, args)
     |> Repo.all()}
  end

  def countries_resolve(_, _) do
    {:ok, Knowledge.list_countries()}
  end

  def companies_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Knowledge.Company, args)
     |> Repo.all()}
  end

  def companies_resolve(_, _) do
    {:ok, Knowledge.list_companies()}
  end

  def airports_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Knowledge.Airport, args)
     |> Repo.all()}
  end

  def airports_resolve(_, _) do
    {:ok, Knowledge.list_airports()}
  end

  def passengers_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Knowledge.Passenger, args)
     |> Repo.all()}
  end

  def passengers_resolve(_, _) do
    {:ok, Knowledge.list_passengers()}
  end

  def plane_types_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Knowledge.PlaneType, args)
     |> Repo.all()}
  end

  def plane_types_resolve(_, _) do
    {:ok, Knowledge.list_plane_types()}
  end

  def planes_resolve(%{filter: _filter} = args, _) do
    {:ok,
     Generic.query_filters(Knowledge.Plane, args)
     |> Repo.all()}
  end

  def planes_resolve(_, _) do
    {:ok, Knowledge.list_planes()}
  end
end
