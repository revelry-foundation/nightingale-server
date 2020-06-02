defmodule Nightingale.Repo.Migrations.RemoveJsonBlob do
  use Ecto.Migration

  def change do
    alter table(:positive_locations) do
      remove(:json_blob)
    end
  end
end
