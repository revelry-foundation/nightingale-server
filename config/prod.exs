use Mix.Config
# NOTE: Compile-time production configuration goes here

config :nightingale, NightingaleWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "localhost", port: {:system, "PORT"}],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true,
  root: ".",
  version: Application.spec(:nightingale, :vsn)

config :nightingale, Nightingale.Repo,
  database: "postgres",
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: "nightingale-database",
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

# Do not print debug messages in production
config :logger, level: :info

config :rollbax, enable_crash_reports: true

config :nightingale, Nightingale.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")
