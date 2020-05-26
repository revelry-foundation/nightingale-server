defmodule Mix.Tasks.Nightingale.GrantAdmin.Test do
  use Nightingale.DataCase, async: true
  alias Mix.Tasks.Nightingale.GrantAdmin
  alias Nightingale.Users
  import ExUnit.CaptureIO

  test "nightingale.make_admin" do
    user = insert(:user)

    assert capture_io(fn ->
             GrantAdmin.run([user.email])
           end) =~ "is now an admin"

    assert Users.get_user(user.id).role == "admin"
  end
end
