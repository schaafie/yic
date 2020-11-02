# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :content_manager,
  namespace: ContentManager,
  ecto_repos: [ContentManager.Repo]

# Configures the endpoint
config :content_manager, ContentManagerWeb.Endpoint,
  url: [host: "localhost"],
  server: false,
  secret_key_base: "wmh3Y3wNXIyEVdpzj/BrMseyxzJk+UvKavn3flLMOSD8zbFb1kMx3W0ogKSItLk5",
  render_errors: [view: ContentManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ContentManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
