defmodule Aerotransit.Token do
  @moduledoc false

  use Joken.Config

  @impl true
  def token_config do
    default_claims(iss: "Aerotransit")
    |> add_claim("sub", nil, &is_valid_uuid/1)
  end

  defp is_valid_uuid(uuid) do
    case UUID.info(uuid) do
      {:ok, _info} ->
        true

      _ ->
        false
    end
  end
end
