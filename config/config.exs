# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :phoenix, :json_library, Jason
config :phoenix, :format_encoders, json: Jason

# General application configuration
config :nightingale,
  ecto_repos: [Nightingale.Repo]

config :nightingale, Nightingale.Repo, types: Nightingale.PostgresTypes

# Configures the endpoint
config :nightingale, NightingaleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gw3/8VC2F03baOWCeJR04cjolFBWIjvzzos1k/ucD5dHdub3Xl39d2QolDGBJ1kk",
  render_errors: [view: NightingaleWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Nightingale.PubSub,
  live_view: [
    signing_salt: "Blf8y9pP"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :rollbax,
  enabled: false,
  environment: "dev"

config :nightingale, Nightingale.Mailer, adapter: Bamboo.LocalAdapter

config :bamboo, :json_library, Jason

config :geo_postgis,
  json_library: Jason

config :ex_aws,
  access_key_id: [System.get_env("AWS_ACCESS_KEY_ID"), :instance_role],
  secret_access_key: [System.get_env("AWS_SECRET_ACCESS_KEY"), :instance_role]

config :nightingale, jwt_secret: "secret"

# see releases.exs for production config
config :nightingale, cluster_topologies: []

config :nightingale, email: {"Nightingale", "noreply@nightingale.org"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
