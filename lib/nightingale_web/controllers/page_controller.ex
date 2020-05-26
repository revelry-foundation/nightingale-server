defmodule NightingaleWeb.PageController do
  use NightingaleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def styleguide(conn, _params) do
    render(conn, "styleguide.html")
  end
end
