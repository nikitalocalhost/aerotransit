defmodule AerotransitWeb.Schema.Generic do
  @moduledoc false

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  import Ecto.Query

  enum :order_direction do
    value(:asc)
    value(:desc)
  end

  input_object :filter do
    field :after, :id
    field :limit, :integer, default_value: 50
    field :order_by, :string, default_value: "updated_at"
    field :order_direction, :order_direction, default_value: :desc
  end

  def query_filters(query, %{
        filter: %{
          after: after_value
        }
      }) do
    from m in query,
      where: ^after_value < m.id
  end

  def query_filters(query, %{
        filters: %{
          limit: limit_value
        }
      }) do
    from m in query,
      limit: ^limit_value
  end

  def query_filters(query, %{
        filters: %{
          order_by: order_by_value
        }
      }) do
    query_filters(query, %{order_by: order_by_value, order_direction: :desc})
  end

  def query_filters(query, %{
        filters: %{
          order_by: order_by_value,
          order_direction: order_direction
        }
      }) do
    order = List.keystore([], order_direction, 0, {order_direction, order_by_value})
    from m in query, order_by: ^order
  end

  def query_filters(query, _) do
    query
  end
end
