defmodule Nightingale.Search do
  import Ecto.Query
  alias Nightingale.{Repo, PositiveLocation, Search}
  alias Search.LocationCheck
  import Geo.PostGIS, only: [st_dwithin_in_meters: 3]

  @proximate_meters_delta 10
  @proximate_duration_delta Timex.Duration.from_minutes(30)

  def find_proximate_positives(%LocationCheck{lng: lng, lat: lat, when: when_mid}) do
    location = %Geo.Point{coordinates: {lng, lat}}
    when_lower = Timex.subtract(when_mid, @proximate_duration_delta)
    when_upper = Timex.add(when_mid, @proximate_duration_delta)

    PositiveLocation
    |> where([pl], st_dwithin_in_meters(pl.location, ^location, @proximate_meters_delta))
    |> where([pl], pl.when >= ^when_lower)
    |> where([pl], pl.when <= ^when_upper)
    |> Repo.all()
  end
end
