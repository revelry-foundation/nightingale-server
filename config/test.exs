use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nightingale, NightingaleWeb.Endpoint,
  http: [port: 4001],
  server: true

config :nightingale, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :nightingale, Nightingale.Repo,
  username: "postgres",
  password: "postgres",
  database: "nightingale_test",
  hostname: "localhost",
  port: String.to_integer(System.get_env("PGPORT") || "5432"),
  pool: Ecto.Adapters.SQL.Sandbox

config :nightingale, Nightingale.Mailer, adapter: Bamboo.TestAdapter

config :nightingale,
  s3_signer: Nightingale.S3Signer.Mock

config :hound,
  driver: "selenium",
  browser: "chrome",
  app_port: 4001,
  genserver_timeout: 480_000

config :cabbage,
  features: "test/integration/feature_files/"
