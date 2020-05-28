defmodule NightingaleWeb.Router do
  use NightingaleWeb, :router
  import Phoenix.LiveDashboard.Router

  use Plug.ErrorHandler

  alias NightingaleWeb.{
    AppDomainRedirect
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
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
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
    pipe_through [:browser]

    forward("/", Adminable.Plug,
      otp_app: :nightingale,
      repo: Nightingale.Repo,
      schemas: [],
      layout: {NightingaleWeb.LayoutView, "app.html"}
    )
  end

  scope "/images" do
    pipe_through([:browser])

    forward("/sign", Transmit,
      signer: Transmit.S3Signer,
      bucket: "nightingale",
      path: "uploads"
    )
  end

  scope "/api", NightingaleWeb.API, as: :api do
    pipe_through([:api])

    scope "/v1", V1, as: :v1 do
      get("/find_proximate_positives", SearchController, :find_proximate_positives)
    end
  end
end
