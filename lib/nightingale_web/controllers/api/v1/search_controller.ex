defmodule NightingaleWeb.API.V1.SearchController do
  use NightingaleWeb, :controller

  alias Nightingale.{Search, PositiveLocation}
  alias Search.LocationCheck

  def find_proximate_positives(conn, params) do
    response_map =
      params
      |> LocationCheck.validate()
      |> case do
        {:ok, location_check} ->
          positives =
            location_check
            |> Search.find_proximate_positives()
            |> Enum.map(&positive_to_map/1)

          %{ok: true, positives: positives}

        {:error, changeset} ->
          %{ok: false, errors: get_changeset_errors_as_map(changeset)}
      end

    json(conn, response_map)
  end

  defp positive_to_map(positive_location) do
    positive_location
    |> PositiveLocation.inflate_virtual_fields()
    |> Map.take([:lng, :lat, :when])
  end
end
