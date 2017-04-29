use Mix.Config

config :annon_api, Annon.DB.Configs.Repo,
  adapter: Ecto.Adapters.Postgres,
  priv: "priv/repos/configs",
  database: "${DB_NAME}",
  username: "${DB_USER}",
  password: "${DB_PASSWORD}",
  hostname: "${DB_HOST}",
  port: "${DB_PORT}"

config :annon_api, Annon.DB.Logger.Repo,
  adapter: Ecto.Adapters.Postgres,
  priv: "priv/repos/logger",
  database: "${DB_NAME}",
  username: "${DB_USER}",
  password: "${DB_PASSWORD}",
  hostname: "${DB_HOST}",
  port: "${DB_PORT}"

config :ex_statsd,
  host: "${STATSD_HOST}",
  port: 8125,
  namespace: "gateway"

config :skycluster,
  strategy: {:system, :module, "SKYCLUSTER_STRATEGY", Cluster.Strategy.Kubernetes},
  kubernetes_selector: {:system, "SKYCLUSTER_KUBERNATES_SELECTOR", "app=annon,component=api"},
  kubernetes_node_basename: {:system, "SKYCLUSTER_KUBERNATES_NODE_BASENAME", "gateway"}
