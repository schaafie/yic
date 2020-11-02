# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :site_manager,
  namespace: SiteManager,
  ecto_repos: [SiteManager.Repo]

# Configures the endpoint
config :site_manager, SiteManagerWeb.Endpoint,
  server: false,
  url: [host: "localhost"],
  secret_key_base: "QpqEiiF7w2+DHoPu1mbG8DKbWG/xuvkl60WPgkVb9PO5dHloqDf6ZnhR7U8TlHzP",
  render_errors: [view: SiteManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SiteManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
