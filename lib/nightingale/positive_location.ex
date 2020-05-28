defmodule Nightingale.PositiveLocation do
  use Ecto.Schema

  import Ecto.{Query, Changeset}, warn: false

  schema "positive_locations" do
    field :json_blob, :map
    field :location, Geo.PostGIS.Geometry
    field :app_version, :string

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(
      params,
      [
        :app_version,
        :json_blob,
      ]
    )
    |> unwrap_location()
    |> validate_required([:json_blob, :app_version, :location])
  end

  defp unwrap_location(changeset) do
    if get_field(changeset, :location) == nil do
      json = get_field(changeset, :json_blob)

      put_change(changeset, :location, generate_geo_point(json))
    end
  end

  defp generate_geo_point(%{lng: long, lat: lat}) do
    %Geo.Point{coordinates: {long, lat}, srid: nil}
  end
  defp generate_geo_point(_), do: nil
end
