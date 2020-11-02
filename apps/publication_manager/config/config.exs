# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :publication_manager,
  namespace: PublicationManager,
  ecto_repos: [PublicationManager.Repo]

# Configures the endpoint
config :publication_manager, PublicationManagerWeb.Endpoint,
  server: false,
  url: [host: "localhost"],
  secret_key_base: "gIaH42IWSXTw/dld9Msj6/sisQLw9A3Me3BLArsjJ2/3X/Lxq3MBJ6qC55mYtI7c",
  render_errors: [view: PublicationManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PublicationManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
