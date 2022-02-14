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

admin = Accounts.create_role(%{name: "admin", priveleges: ["read_all", "write_all"]})
moderator = Accounts.create_role(%{name: "moderator", priveleges: ["read_all"]})
user = Accounts.create_role(%{name: "user", priveleges: []})

admin_user = Accounts.create_user(%{username: "admin", password: "admin", role: admin.id})
