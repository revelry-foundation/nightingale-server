defmodule Nightingale.SearchTest do
  use Nightingale.DataCase, async: true
  alias Nightingale.Search
  alias Search.LocationCheck

  test "find_proximate_positives/1" do
    ploc = insert(:positive_location)
    %{when: when_at, location: %{coordinates: {lng, lat}}} = ploc

    lcheck = %LocationCheck{lng: lng, lat: lat, when: when_at}

    assert [ploc] = Search.find_proximate_positives(lcheck)

    lcheck = %LocationCheck{lat: lat + 10.0, lng: lng, when: when_at}

    assert [] = Search.find_proximate_positives(lcheck)

    lcheck = %LocationCheck{lat: lat, lng: lng + 10.0, when: when_at}

    assert [] = Search.find_proximate_positives(lcheck)

    lcheck = %LocationCheck{
      lat: lat,
      lng: lng,
      when: Timex.add(when_at, Timex.Duration.from_minutes(120))
    }

    assert [] = Search.find_proximate_positives(lcheck)

    lcheck = %LocationCheck{
      lat: lat,
      lng: lng,
      when: Timex.subtract(when_at, Timex.Duration.from_minutes(120))
    }

    assert [] = Search.find_proximate_positives(lcheck)
  end
end
