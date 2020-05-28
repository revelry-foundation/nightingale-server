defmodule Nightingale.SearchLocationCheckTest do
  use Nightingale.DataCase, async: true
  alias Nightingale.Search.LocationCheck
  alias Ecto.Changeset

  @valid_lat_list [
    90.0,
    10,
    23.61443461
  ]
  @valid_lng_list @valid_lat_list
  @valid_when_list [
    "2020-05-28T17:21:29.118Z",
    "2020-05-28T18:16:00.433Z"
  ]

  @invalid_lat_list [
    nil,
    "",
    "asdf"
  ]
  @invalid_lng_list @invalid_lat_list
  @invalid_when_list [
    nil,
    "",
    "asdf",
    "2020-05-28"
  ]

  @valid_location_check_params %{
    "lat" => hd(@valid_lat_list),
    "lng" => hd(@valid_lng_list),
    "when" => hd(@valid_when_list)
  }

  describe "LocationCheck" do
    test "validate/1" do
      Enum.each(@valid_lat_list, fn x ->
        assert {:ok, %LocationCheck{}} =
                 LocationCheck.validate(%{@valid_location_check_params | "lat" => x})
      end)

      Enum.each(@valid_lng_list, fn x ->
        assert {:ok, %LocationCheck{}} =
                 LocationCheck.validate(%{@valid_location_check_params | "lng" => x})
      end)

      Enum.each(@valid_when_list, fn x ->
        assert {:ok, %LocationCheck{}} =
                 LocationCheck.validate(%{@valid_location_check_params | "when" => x})
      end)

      Enum.each(@invalid_lat_list, fn x ->
        assert {:error, %Changeset{}} =
                 LocationCheck.validate(%{@valid_location_check_params | "lat" => x})
      end)

      Enum.each(@invalid_lng_list, fn x ->
        assert {:error, %Changeset{}} =
                 LocationCheck.validate(%{@valid_location_check_params | "lng" => x})
      end)

      Enum.each(@invalid_when_list, fn x ->
        assert {:error, %Changeset{}} =
                 LocationCheck.validate(%{@valid_location_check_params | "when" => x})
      end)
    end
  end
end
