# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :asset_manager,
  namespace: AssetManager,
  ecto_repos: [AssetManager.Repo]

# Configures the endpoint
config :asset_manager, AssetManagerWeb.Endpoint,
  server: false,
  url: [host: "localhost"],
  secret_key_base: "XHKOnz7qFkMDvN4YwZfFUjWqYz08i2Hbz2IVINfybFtwSJ2KxWY5HmZ1GHkMJxt8",
  render_errors: [view: AssetManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: AssetManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
