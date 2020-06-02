defmodule Nightingale.PositiveLocationsTest do
  use Nightingale.DataCase, async: true
  import Nightingale.PositiveLocations
  alias Nightingale.PositiveLocation

  test "create_positive_location/1" do
    lng = 90.0
    lat = 90.0
    when_str = "2020-05-28T17:21:29Z"
    {:ok, when_dt, _} = DateTime.from_iso8601(when_str)
    app_version = "foo"

    assert {:ok, %PositiveLocation{} = ploc} =
             create_positive_location(%{
               lng: lng,
               lat: lat,
               when: when_str,
               app_version: app_version
             })

    assert ploc.location.coordinates == {lng, lat}
    assert ploc.when == when_dt
    assert ploc.app_version == app_version
  end
end
