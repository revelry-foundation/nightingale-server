defmodule Nightingale.Search do
  import Ecto.Query
  alias Nightingale.{Repo, PositiveLocation, Search}
  alias Search.LocationCheck
  import Geo.PostGIS, only: [st_dwithin_in_meters: 3]

  @proximate_meters_delta 10
  # @proximate_minutes_delta 30

  def find_proximate_positives(%LocationCheck{lat: lat, lng: lng, when: _at_when}) do
    location = %Geo.Point{coordinates: {lat, lng}}

    query =
      from(pl in PositiveLocation,
        where: st_dwithin_in_meters(pl.location, ^location, @proximate_meters_delta)
      )

    Repo.all(query)
  end
end
