defmodule AerotransitWeb.PageControllerTest do
  use AerotransitWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Aerotransit"
  end
end
