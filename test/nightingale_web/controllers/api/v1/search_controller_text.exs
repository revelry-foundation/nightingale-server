defmodule NightingaleWeb.API.V1.SearchControllerTest do
  use NightingaleWeb.ConnCase, async: true

  test "GET /api/v1/find_proximate_positives with valid params", %{conn: conn} do
    conn =
      get(conn, "/api/v1/find_proximate_positives", %{
        "lat" => 90.0,
        "lng" => 90.0,
        "when" => "2020-05-28T18:16:00.433Z"
      })

    json = json_response(conn, 200)

    assert %{"ok" => true, "positives" => positives} = json
    assert is_list(positives)
  end

  test "GET /api/v1/find_proximate_positives with invalid params", %{conn: conn} do
    conn =
      get(conn, "/api/v1/find_proximate_positives", %{
        "lat" => 90.0,
        "lng" => 90.0,
        "when" => "invalid value"
      })

    json = json_response(conn, 200)

    assert %{"ok" => false, "errors" => %{"when" => when_errors}} = json
    assert is_list(when_errors)
  end
end
