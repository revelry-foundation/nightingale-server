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
        :version,
        :document_status,
      ]
    )
    |> unwrap_location()
    |> validate_required([:customer_id, :contract, :location])
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

defimpl Jason.Encoder, for: Nightingale.PositiveLocation do
  def encode(%{name: name, location: location}, opts) do
    %{lat: lat, lng: lng} = decode_location(location)

    Jason.Encode.map(%{name: name, lat: lat, lng: lng}, opts)
  end

  defp decode_location(%{coordinates: {lng, lat}}) do
    %{lat: lat, lng: lng}
  end

  defp decode_location(%{}) do
    %{lat: nil, lng: nil}
  end
end
