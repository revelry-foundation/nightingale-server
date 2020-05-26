defmodule Mix.Tasks.Nightingale.GrantAdmin do
  use Mix.Task

  alias Nightingale.{ReleaseTasks}

  @shortdoc "Grants the given user admin access"

  @moduledoc """
  Grants the given user admin access

  usage:

  mix nightingale.grant_admin <email>
  """

  @doc false
  def run([email]) do
    Mix.Task.run("app.start")
    ReleaseTasks.grant_admin_permissions(email)
  end
end
