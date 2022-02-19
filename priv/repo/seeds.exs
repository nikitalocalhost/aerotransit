# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Aerotransit.Repo.insert!(%Aerotransit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Aerotransit.{Repo, Accounts}

{:ok, admin} = Accounts.create_role(%{name: "admin", priveleges: ["read_all", "write_all"]})
{:ok, moderator} = Accounts.create_role(%{name: "moderator", priveleges: ["read_all"]})
{:ok, user} = Accounts.create_role(%{name: "user", priveleges: []})

{:ok, admin_user} =
  Accounts.create_user(%{username: "admin", password: "admin", role_id: admin.id})
