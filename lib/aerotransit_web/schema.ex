defmodule AerotransitWeb.Schema do
  @moduledoc false

  use Absinthe.Schema

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
  end

  query do
    @desc "Get all posts"
    field :posts, list_of(:post) do
      resolve(&Resolvers.Content.list_posts/3)
    end
  end
end
