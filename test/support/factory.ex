defmodule Nightingale.Factory do
  alias Nightingale.{Repo}
  use ExMachina.Ecto, repo: Repo
end
