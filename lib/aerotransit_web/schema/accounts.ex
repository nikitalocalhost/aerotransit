defmodule AerotransitWeb.Schema.Accounts do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias Aerotransit.Accounts

  object :tokens do
    field :token, :string
    field :refresh_token, :string
  end

  object :role do
    field :id, :id
    field :name, :string
    field :priveleges, list_of(:string)
  end

  input_object :user_auth do
    field :username, non_null(:string)
    field :password, non_null(:string)
  end

  object :user do
    field :id, :id
    field :username, :string
    field :role, :role, resolve: dataloader(Accounts)
  end

  object :account_queries do
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(fn %{id: user_id}, _ ->
        case Accounts.get_user(user_id) do
          nil -> {:error, "Not found"}
          user -> {:ok, user}
        end
      end)
    end
  end

  object :account_mutations do
    field :authorize, :tokens do
      arg(:user, non_null(:user_auth))

      # resolve(fn _parent, %{user: user}, %{context: %{current_user: _current_user}} ->
      resolve(fn _parent, %{user: user}, _context ->
        with {:ok, user} <- Accounts.User.verify_user(user),
             {:ok, tokens} <- Accounts.User.generate_tokens(user) do
          {:ok, tokens}
        else
          {:error, err} ->
            {:error, "Password is wrong or user is not found"}

          _ ->
            {:error, "Password is wrong or user is not found"}
        end
      end)
    end
  end
end
