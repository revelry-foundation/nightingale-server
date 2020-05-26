defmodule NightingaleWeb.API.MeView do
  use NightingaleWeb, :view

  def render("show.json", %{user: user}) do
    %{
      data: %{
        id: user.id,
        email: user.email
      }
    }
  end
end
