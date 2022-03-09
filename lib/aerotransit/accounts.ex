defmodule Aerotransit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Aerotransit.Repo

  alias Aerotransit.Accounts.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  alias Aerotransit.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_by!(username: "admin")
      %User{}

      iex> get_user_by!(username: "qwerty")
      ** (Ecto.NoResultsError)

  """
  def get_user_by!(params), do: Repo.get_by!(User, params)

  @doc """
  Gets a single user.

  Returns `nil` if the User does not exist.

  ## Examples

      iex> get_user_by(username: "admin")
      {:ok, %User{}}

      iex> get_user_by(username: "qwerty")
      {:err, "Not found"}

  """
  def get_user_by(params) do
    case(Repo.get_by(User, params)) do
      nil -> {:err, "Not found"}
      data -> {:ok, data}
    end
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.

  ## Examples

      iex> get_user(123)
      {:ok, %User{}}

      iex> get_user(456)
      {:error, "Not found"}

  """
  def get_user(id) do
    case(Repo.get(User, id)) do
      nil -> {:error, "Not found"}
      data -> {:ok, data}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def verify_user(%User{} = user, password) do
    user
    |> Argon2.check_pass(password)
  end

  def user_generate_tokens(%User{id: id}) do
    case Aerotransit.Token.generate_and_sign(%{"iss" => id}) do
      {:ok, token, _claims} ->
        case Aerotransit.Token.generate_and_sign(%{"iss" => id, "type" => "refresh"}) do
          {:ok, refresh_token, _claims} ->
            {:ok, %{token: token, refresh_token: refresh_token}}

          _ ->
            {:error, "Error while generating refresh token"}
        end

      _ ->
        {:error, "Error while generating token"}
    end
  end

  def user_auth(%{username: username, password: password}) do
    with {:ok, user} <- get_user_by(username: username),
         {:ok, _user} <- verify_user(user, password),
         {:ok, tokens} <- user_generate_tokens(user) do
      {:ok, %{user: user, tokens: tokens}}
    else
      _ ->
        {:error, "Password is wrong or user is not found"}
    end
  end

  def data() do
    Dataloader.Ecto.new(Aerotransit.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
