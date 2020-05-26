defmodule Mix.Tasks.Nightingale.RevokeAdmin.Test do
  use Nightingale.DataCase, async: true
  alias Mix.Tasks.Nightingale.RevokeAdmin
  alias Nightingale.Users
  import ExUnit.CaptureIO

  test "nightingale.revoke_admin" do
    user = insert(:user)

    assert capture_io(fn ->
             RevokeAdmin.run([user.email])
           end) =~ "admin access revoked"

    assert Users.get_user(user.id).role == "user"
  end
end
