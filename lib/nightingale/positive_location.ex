defmodule Nightingale.PositiveLocation do
  use Ecto.Schema

  import Ecto.{Query, Changeset}, warn: false

  schema "positive_locations" do
    field(:location, Geo.PostGIS.Geometry)
    field(:lng, :float, virtual: true)
    field(:lat, :float, virtual: true)
    field(:app_version, :string)
    field(:when, :utc_datetime)

    timestamps()
  end

  def changeset(attrs \\ %{}) do
    %__MODULE__{}
    |> cast(attrs, [:location, :lng, :lat, :when, :app_version])
    |> update_location()
    |> validate_required([:location, :when, :app_version])
  end

  @srid_geographic_coordinates 4326

  defp geo_point(lng: lng, lat: lat) do
    %Geo.Point{coordinates: {lng, lat}, srid: @srid_geographic_coordinates}
  end

  defp update_location(changeset) do
    case get_change(changeset, :location) do
      nil ->
        if is_nil(get_change(changeset, :lng)) and is_nil(get_change(changeset, :lat)) do
          changeset
        else
          location = geo_point(lng: get_field(changeset, :lng), lat: get_field(changeset, :lat))
          put_change(changeset, :location, location)
        end

      _ ->
        changeset
    end
  end

  def inflate(%__MODULE__{location: %Geo.Point{coordinates: {lng, lat}}} = struct) do
    %{struct | lng: lng, lat: lat}
  end
end
