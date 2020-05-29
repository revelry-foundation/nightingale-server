defmodule Nightingale.Repo.Migrations.AddIndexesToPositiveLocations do
  use Ecto.Migration

  def up do
    create(index(:positive_locations, [:location], using: :gist))
    create(index(:positive_locations, [:when]))
  end

  def down do
    drop(index(:positive_locations, [:location]))
    drop(index(:positive_locations, [:when]))
  end
end
