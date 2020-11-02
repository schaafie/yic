# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api_manager,
  namespace: ApiManager,
  ecto_repos: [ApiManager.Repo]

# Configures the endpoint
config :api_manager, ApiManagerWeb.Endpoint,
  server: false,
  url: [host: "localhost"],
  secret_key_base: "k6CwWmsCM/wBXUBxyf4rS5rby7P72PutaLzAsmgCxCktWeXi6aiuE7i+wmTGwSYN",
  render_errors: [view: ApiManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ApiManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
