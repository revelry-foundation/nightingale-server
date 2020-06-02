defmodule Nightingale.Factory do
  alias Nightingale.{Repo}
  use ExMachina.Ecto, repo: Repo

  def geo_point() do
    %Geo.Point{coordinates: {0.0, 0.0}}
  end

  def datetime(str) when is_bitstring(str) do
    {:ok, dt, _} = DateTime.from_iso8601(str)
    dt
  end

  def positive_location_factory() do
    %Nightingale.PositiveLocation{
      location: geo_point(),
      when: datetime("2020-05-28T17:21:29Z")
    }
  end
end
