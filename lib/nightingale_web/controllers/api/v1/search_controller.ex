defmodule NightingaleWeb.API.V1.SearchController do
  use NightingaleWeb, :controller

  alias Nightingale.Search.LocationCheck

  def find_proximate_positives(conn, params) do
    response_map =
      params
      |> LocationCheck.validate()
      |> case do
        {:ok, _location_check} ->
          %{
            ok: true,
            positives: [
              %{
                lat: 90.0,
                lng: 90.0,
                when: "2020-05-28T17:21:29.118Z"
              },
              %{
                lat: 90.0,
                lng: 90.0,
                when: "2020-05-28T17:21:29.118Z"
              }
            ]
          }

        {:error, changeset} ->
          %{
            ok: false,
            errors: get_changeset_errors_as_map(changeset)
          }
      end

    json(conn, response_map)
  end
end
