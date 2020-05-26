defmodule NightingaleWeb.Router do
  use NightingaleWeb, :router
  use Pow.Phoenix.Router
  import Phoenix.LiveDashboard.Router

  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation]

  use Plug.ErrorHandler

  alias NightingaleWeb.{
    APIAuthentication,
    AppDomainRedirect,
    BrowserAuthentication,
    RequirePermission
  }

  defp handle_errors(conn, error_data) do
    NightingaleWeb.ErrorReporter.handle_errors(conn, error_data)
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {NightingaleWeb.LayoutView, :root}
    plug AppDomainRedirect
    plug BrowserAuthentication, otp_app: :nightingale
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug APIAuthentication, otp_app: :nightingale
  end

  pipeline :require_admin do
    plug RequirePermission, permission: :administrator
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :anonymous do
    plug Pow.Plug.RequireNotAuthenticated, error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", NightingaleWeb do
    # Use the default browser stack
    pipe_through [:browser]
    get "/", PageController, :index
    get "/styleguide", PageController, :styleguide
  end

  if Mix.env() == :dev do
    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard"
    end
  end

  scope "/admin" do
    pipe_through [:browser, :protected, :require_admin]

    forward("/", Adminable.Plug,
      otp_app: :nightingale,
      repo: Nightingale.Repo,
      schemas: [Nightingale.User],
      layout: {NightingaleWeb.LayoutView, "app.html"}
    )
  end

  scope "/images" do
    pipe_through([:browser, :protected])

    forward("/sign", Transmit,
      signer: Transmit.S3Signer,
      bucket: "nightingale",
      path: "uploads"
    )
  end

  scope "/api", NightingaleWeb.API, as: :api do
    pipe_through [:api]

    get "/", MeController, :show
  end
end
