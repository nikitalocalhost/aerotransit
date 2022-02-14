defmodule AerotransitWeb.PageController do
  use AerotransitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
