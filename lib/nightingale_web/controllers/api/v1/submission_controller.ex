defmodule NightingaleWeb.API.V1.SubmissionController do
  use NightingaleWeb, :controller

  alias Nightingale.Search.LocationCheck
  alias Nightingale.{PositiveLocation, Repo}

  def submit_positive_location(conn, params) do
    response_map =
      params
      |> LocationCheck.validate()
      |> case do
        {:ok, _location_check} ->
          params
          |> Map.merge(%{"json_blob" => params})
          |> PositiveLocation.changeset()
          |> Repo.insert()
          |> case do
            {:ok, _} ->
              %{ok: true}
            {:error, changeset} ->
              %{
                ok: false,
                errors: get_changeset_errors_as_map(changeset)
              }
          end


        {:error, changeset} ->
          %{
            ok: false,
            errors: get_changeset_errors_as_map(changeset)
          }
      end

    json(conn, response_map)
  end
end
