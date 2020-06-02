defmodule NightingaleWeb.API.V1.SearchControllerTest do
  use NightingaleWeb.ConnCase, async: true

  test "GET /api/v1/find_proximate_positives with valid params", %{conn: conn} do
    # Not inserting it yet, so there should be no matches.
    ploc = build(:positive_location)

    %{when: dt_when, location: %{coordinates: {lng, lat}}} = ploc
    str_when = DateTime.to_iso8601(dt_when)
    params = %{"lng" => lng, "lat" => lat, "when" => str_when}

    conn = get(conn, "/api/v1/find_proximate_positives", params)

    assert json_response(conn, 200) == %{"ok" => true, "positives" => []}

    # Inserting it now, so now we should get 1 match.
    insert(ploc)

    conn = get(conn, "/api/v1/find_proximate_positives", params)

    assert json_response(conn, 200) == %{"ok" => true, "positives" => [params]}
  end

  test "GET /api/v1/find_proximate_positives with invalid params", %{conn: conn} do
    conn =
      get(conn, "/api/v1/find_proximate_positives", %{
        "lng" => 90.0,
        "lat" => 90.0,
        "when" => "invalid value"
      })

    json = json_response(conn, 200)

    assert %{"ok" => false, "errors" => %{"when" => when_errors}} = json
    assert is_list(when_errors)
  end
end
