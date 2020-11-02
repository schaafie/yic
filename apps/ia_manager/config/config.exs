# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ia_manager,
  namespace: IaManager,
  ecto_repos: [IaManager.Repo]

# Configures the endpoint
config :ia_manager, IaManagerWeb.Endpoint,
  server: false,
  url: [host: "localhost"],
  secret_key_base: "ZsdsMd87AzlKQhTT5U1O25iW2RSZLT20ghB/uUG+9CZbPWwMofyZsWEy5+Jr13up",
  render_errors: [view: IaManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: IaManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
