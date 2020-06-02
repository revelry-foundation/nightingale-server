defmodule Nightingale.Search.LocationCheck do
  @moduledoc """
  For validating search params for one location.
  """

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:lat, :float)
    field(:lng, :float)
    field(:when, :utc_datetime)
  end

  @required_fields [
    :lat,
    :lng,
    :when
  ]

  defp changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  def validate(attrs) do
    attrs
    |> changeset()
    |> apply_action(:insert)
  end
end
