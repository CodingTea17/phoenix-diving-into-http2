# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :diving_into_http2, DivingIntoHttp2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J3Q5/a5EsOfotl29+PXkZmxYWZESqR9pnE8dCEsigLIGyAtolHWquXHcucvO2tf7",
  render_errors: [view: DivingIntoHttp2Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DivingIntoHttp2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
