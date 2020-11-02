# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api_web,
  namespace: ApiWeb

# Configures the endpoint
config :api_web, ApiWeb.Endpoint,
  server: true,
  url: [host: "localhost"],
  secret_key_base: "LGPPFB8OPWQGRYKS0qAZhKWG/CQWvZU1k4QCv/wlPYvTey6g++hMnG0jaurlhfHW",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ApiWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :api_web, :generators,
  context_app: :api

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
