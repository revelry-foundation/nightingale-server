defmodule NightingaleWeb.FallbackController do
  use NightingaleWeb, :controller

  def call(conn, :not_found) do
    conn
    |> put_status(404)
    |> put_view(NightingaleWeb.ErrorView)
    |> render("404.html")
  end
end
