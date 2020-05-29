defmodule Nightingale.SearchTest do
  use Nightingale.DataCase, async: true
  alias Nightingale.{PositiveLocation, Search}
  alias Search.LocationCheck

  test "find_proximate_positives/1" do
    exact_match = insert(:positive_location)
    %{when: when_at, location: %{coordinates: {lat, lng}}} = exact_match

    lcheck = %LocationCheck{lat: lat, lng: lng, when: when_at}

    assert [exact_match] = Search.find_proximate_positives(lcheck)
  end
end
