# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :user_manager,
  namespace: UserManager,
  ecto_repos: [UserManager.Repo]

# Configures the endpoint
config :user_manager, UserManagerWeb.Endpoint,
  url: [host: "localhost"],
  server: false,
  secret_key_base: "u3h065Y4lybC8nIfia2VUIZnkPpHS+0o+BjSygEbVOvP7oLAISDlRJiwiwDIaA1Q",
  render_errors: [view: UserManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: UserManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
