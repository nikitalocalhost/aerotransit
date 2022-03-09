defmodule Aerotransit.Seed do
  @moduledoc false
  # alias Aerotransit.Repo
  alias Aerotransit.Accounts

  # TODO: check if object already in db

  def seed do
    {:ok, admin} = Accounts.create_role(%{name: "admin", priveleges: ["read_all", "write_all"]})
    {:ok, _moderator} = Accounts.create_role(%{name: "moderator", priveleges: ["read_all"]})
    {:ok, _user} = Accounts.create_role(%{name: "user", priveleges: []})

    {:ok, _admin_user} =
      Accounts.create_user(%{username: "admin", password: "admin", role_id: admin.id})
  end

  # defp create_or_find(module, find \\ [], attrs \\ %{}) do
  #   case Repo.get_by(module, find) do
  #     nil ->
  #       case Repo.insert(attrs) do
  #         {:ok, data} ->
  #           data

  #         {:error, error} ->
  #           IO.write(:stderr, error)
  #           throw("Not found and insert is failed")

  #         _ ->
  #           throw("Not found and insert is failed")
  #       end

  #     data ->
  #       data
  #   end
  # end
end
