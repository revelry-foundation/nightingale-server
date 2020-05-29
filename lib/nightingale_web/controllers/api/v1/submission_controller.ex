defmodule NightingaleWeb.API.V1.SubmissionController do
  use NightingaleWeb, :controller

  alias Nightingale.{PositiveLocations}

  def submit_positive_location(conn, params) do
    response_map =
      params
      |> PositiveLocations.create_positive_location()
      |> case do
        {:ok, _} ->
          %{ok: true}

        {:error, changeset} ->
          %{ok: false, errors: get_changeset_errors_as_map(changeset)}
      end

    json(conn, response_map)
  end
end
