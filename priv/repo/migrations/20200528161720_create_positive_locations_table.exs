defmodule Nightingale.Repo.Migrations.CreatePositiveLocationsTable do
  use Ecto.Migration

  def up do
    create table(:positive_locations) do
      add(:location, :geometry)
      add(:json_blob, :map)
      add(:app_version, :string)
      add(:when, :utc_datetime)

      timestamps()
    end
  end

  def down do
    drop table(:positive_locations)
  end
end
