# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Logger:
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:module, :request_id]

# Phoenix endpoint:
config :gateway, Gateway.Endpoint,
  url: [host: System.get_env("HOST") || "localhost"],
  http: [port: System.get_env("PORT") || 4000],
  render_errors: [view: Gateway.ErrorView, accepts: ~w(json), default_format: "json"],
  pubsub: [name: Gateway.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Authentication:
config :gateway, auth_jwt_key: "supersecrettoken"
config :gateway, auth_jwt_blacklist_default_expiry_hours: 1

# Proxy:
config :gateway, proxy_config_file: "proxy/proxy.json"

# Kafka:
kafka_client_id = :gateway_brod_client
config :gateway, kafka_broker_csv_list: System.get_env("KAFKA_HOSTS") || "localhost:9092"
config :gateway, kafka_client_id: kafka_client_id
config :gateway, kafka_consumer_group_id: "gateway-consumer-group"
config :gateway, kafka_consumed_topics: ["message"]
config :gateway, kafka_call_log_topic: "message"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"