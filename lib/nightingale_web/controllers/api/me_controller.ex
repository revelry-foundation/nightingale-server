defmodule NightingaleWeb.API.MeController do
  use NightingaleWeb, :controller

  def show(conn, _params) do
    render(conn, "show.json", user: conn.assigns.current_user)
  end
end
