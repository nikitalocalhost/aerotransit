defmodule AerotransitWeb.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(AerotransitWeb.Schema.Generic)

  import_types(AerotransitWeb.Schema.Accounts)
  import_types(AerotransitWeb.Schema.Knowledge)
  import_types(AerotransitWeb.Schema.Flights)

  alias Aerotransit.{Accounts, Knowledge, Flights}

  query do
    import_fields(:account_queries)
    import_fields(:knowledge_queries)
    import_fields(:flights_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:knowledge_mutations)
    import_fields(:flights_mutations)

    field :simulate_up, non_null(:boolean) do
      resolve(fn _, _ -> Aerotransit.Simulation.simulate_up() end)
    end

    field :simulate_down, non_null(:boolean) do
      resolve(fn _, _ -> Aerotransit.Simulation.simulate_down() end)
    end
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.data())
      |> Dataloader.add_source(Knowledge, Knowledge.data())
      |> Dataloader.add_source(Flights, Flights.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
