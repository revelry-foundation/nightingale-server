defmodule Nightingale.PositiveLocations do
  alias Nightingale.{Repo, PositiveLocation}

  def create_positive_location(attrs) do
    attrs
    |> PositiveLocation.changeset()
    |> Repo.insert()
  end
end
