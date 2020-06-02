defmodule NightingaleWeb.ErrorReporter.Test do
  use NightingaleWeb.ConnCase, async: true
  alias NightingaleWeb.ErrorReporter

  test "handle_errors when one of ignored routes" do
    assert ErrorReporter.handle_errors(%{request_path: "/wp-login.php"}, []) == nil
  end

  test "handle_errors when there is an error and user not logged in" do
    conn = build_conn()

    assert ErrorReporter.handle_errors(conn, %{
             kind: :error,
             reason: "error",
             stack: []
           }) == :ok
  end
end
