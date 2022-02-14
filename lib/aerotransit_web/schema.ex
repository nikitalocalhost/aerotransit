defmodule AerotransitWeb.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types(AerotransitWeb.Schema.Accounts)

  alias Aerotransit.{Accounts}

  query do
    import_fields(:account_queries)
  end

  mutation do
    import_fields(:account_mutations)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
