defmodule NightingaleWeb.API.V1.SubmissionControllerTest do
  use NightingaleWeb.ConnCase, async: true

  test "POST /api/v1/submit_positive_location with valid params", %{conn: conn} do
    params = %{
      "lat" => 90.0,
      "lng" => 90.0,
      "when" => "2020-05-28T18:16:00Z",
      "app_version" => "0.1"
    }

    conn = post(conn, "/api/v1/submit_positive_location", params)

    assert json_response(conn, 200) == %{
             "ok" => true,
             "data" => Map.take(params, ["lat", "lng", "when"])
           }
  end

  test "POST /api/v1/submit_positive_location with invalid location params", %{conn: conn} do
    conn =
      post(conn, "/api/v1/submit_positive_location", %{
        "lat" => 90.0,
        "lng" => 90.0,
        "when" => "invalid value"
      })

    json = json_response(conn, 200)

    assert %{"ok" => false, "errors" => %{"when" => when_errors}} = json
    assert is_list(when_errors)
  end
end
