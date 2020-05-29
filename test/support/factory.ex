defmodule Nightingale.Factory do
  alias Nightingale.{Repo}
  use ExMachina.Ecto, repo: Repo

  def geo_point() do
    %Geo.Point{coordinates: {90.0, 90.0}}
  end

  def positive_location_factory() do
    %Nightingale.PositiveLocation{
      json_blob: %{},
      location: geo_point(),
      when: "2020-05-28T17:21:29.118Z"
    }
  end
end
