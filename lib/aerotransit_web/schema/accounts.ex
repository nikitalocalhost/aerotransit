defmodule AerotransitWeb.Schema.Accounts do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias Aerotransit.Accounts

  object :role do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:priveleges, :string |> non_null |> list_of |> non_null)
  end

  input_object :user_auth do
    field(:username, non_null(:string))
    field(:password, non_null(:string))
  end

  object :user do
    field(:id, non_null(:id))
    field(:username, non_null(:string))
    field(:role, non_null(:role), resolve: dataloader(Accounts))
  end

  object :tokens do
    field(:token, non_null(:string))
    field(:refresh_token, non_null(:string))
  end

  object :authorize do
    field(:tokens, non_null(:tokens))
    field(:user, non_null(:user))
  end

  object :account_queries do
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(fn %{id: user_id}, _ -> Accounts.get_user(user_id) end)
    end
  end

  object :account_mutations do
    field :authorize, :authorize do
      arg(:user, non_null(:user_auth))

      resolve(fn _parent, %{user: user}, _context ->
        case Accounts.user_auth(user) do
          {:ok, %{user: user, tokens: tokens}} ->
            {:ok, %{user: user, tokens: tokens}}

          _ ->
            {:error, "Password is wrong or user is not found"}
        end
      end)
    end

    field :refresh_auth, :tokens do
      arg(:refresh_token, non_null(:string))

      resolve(fn _parent, %{refresh_token: refresh_token}, _context ->
        with {:ok, %{"type" => "refresh", "iss" => iss}} <-
               Aerotransit.Token.verify_and_validate(refresh_token),
             {:ok, user} <- Accounts.get_user(iss) do
          Accounts.user_generate_tokens(user)
        else
          _ -> {:error, "Refresh token is wrong"}
        end
      end)
    end
  end
end
