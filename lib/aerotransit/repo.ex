defmodule Aerotransit.Repo do
  use Ecto.Repo,
    otp_app: :aerotransit,
    adapter: Ecto.Adapters.Postgres
end
