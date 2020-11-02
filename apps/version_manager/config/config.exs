# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :version_manager,
  namespace: VersionManager,
  ecto_repos: [VersionManager.Repo]

# Configures the endpoint
config :version_manager, VersionManagerWeb.Endpoint,
  url: [host: "localhost"],
  server: false,
  secret_key_base: "Cj/ZhFpYHeDm14PC16X6koBJuZ+D9h566krS8OS9He1LCaFXb3O5ABRrKfMej0rM",
  render_errors: [view: VersionManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: VersionManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
