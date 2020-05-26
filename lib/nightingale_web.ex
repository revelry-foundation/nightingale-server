defmodule NightingaleWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use NightingaleWeb, :controller
      use NightingaleWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: NightingaleWeb
      import Plug.Conn
      alias NightingaleWeb.Router.Helpers, as: Routes
      import NightingaleWeb.Gettext
      import Phoenix.LiveView.Controller
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/nightingale_web/templates",
        namespace: NightingaleWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      alias NightingaleWeb.Router.Helpers, as: Routes
      import NightingaleWeb.ErrorHelpers
      import NightingaleWeb.Gettext
      import Harmonium
      import Phoenix.LiveView.Helpers
      import NightingaleWeb.LiveHelpers
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {NightingaleWeb.LayoutView, "live.html"}

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
      import Phoenix.View

      alias NightingaleWeb.Router.Helpers, as: Routes
      import NightingaleWeb.ErrorHelpers
      import NightingaleWeb.Gettext
      import Harmonium
      import Phoenix.LiveView.Helpers
      import NightingaleWeb.LiveHelpers
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
      import Phoenix.View

      alias NightingaleWeb.Router.Helpers, as: Routes
      import NightingaleWeb.ErrorHelpers
      import NightingaleWeb.Gettext
      import Harmonium
      import Phoenix.LiveView.Helpers
      import NightingaleWeb.LiveHelpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import NightingaleWeb.Gettext
    end
  end

  def mailer_view do
    quote do
      use Phoenix.View,
        root: "lib/nightingale_web/templates",
        namespace: MyAppWeb

      use Phoenix.HTML
      import NightingaleWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
