import Config
# NOTE: Runtime production configuration goes here

config :nightingale, Nightingale.Repo,
  database: System.get_env("POSTGRES_DATABASE") || "postgres",
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: System.get_env("POSTGRES_HOSTNAME") || "nightingale-database",
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :nightingale, NightingaleWeb.Endpoint,
  http: [port: String.to_integer(System.get_env("PORT"))],
  url: [scheme: "https", host: System.get_env("APP_DOMAIN"), port: 443],
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :rollbax,
  client_token: System.get_env("ROLLBAR_CLIENT_TOKEN"),
  access_token: System.get_env("ROLLBAR_SERVER_TOKEN"),
  environment: System.get_env("ROLLBAR_ENVIRONMENT"),
  # TODO: turn on when your app is deployed
  enabled: false

config :nightingale, Nightingale.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")

config :nightingale,
  jwt_secret: System.get_env("JWT_SECRET") || System.get_env("SECRET_KEY_BASE")

# Configure Cluster Nodes
app_name = System.get_env("APP_NAME") || "nightingale"

config :nightingale, cluster_enabled: System.get_env("CLUSTER_ENABLED") == "1"

config :nightingale,
  cluster_topologies: [
    k8s: [
      strategy: Elixir.Cluster.Strategy.Kubernetes.DNS,
      config: [
        # the name of the "headless" service in the app's k8s configuration
        service: "#{app_name}-nodes",
        # the `app` tag applied to k8s resources for this app
        application_name: app_name
      ]
    ]
  ]
