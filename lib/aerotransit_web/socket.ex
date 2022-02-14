defmodule AerotransitWeb.Socket do
  @moduledoc false

  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: AerotransitWeb.Schema

  def connect(params, socket) do
    current_user = current_user(params)

    socket =
      Absinthe.Phoenix.Socket.put_options(socket,
        context: %{
          current_user: current_user
        }
      )

    {:ok, socket}
  end

  defp current_user(%{"user_id" => id}) do
    Aerotransit.Repo.get(User, id)
  end

  defp current_user(_params) do
    nil
  end

  def id(_socket), do: nil
end
