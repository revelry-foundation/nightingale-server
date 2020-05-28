defmodule Nightingale.SearchTest do
  use Nightingale.DataCase, async: true
  alias Nightingale.{PositiveLocation, Search}
  alias Search.LocationCheck

  test "find_proximate_positives/1" do
    lcheck = %LocationCheck{
      lat: 90.0,
      lng: 90.0,
      when: DateTime.from_iso8601("2020-05-28T17:21:29.118Z")
    }

    result = Search.find_proximate_positives(lcheck)

    assert is_list(result)
  end
end
