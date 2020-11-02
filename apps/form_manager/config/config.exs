# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :form_manager,
  namespace: FormManager,
  ecto_repos: [FormManager.Repo]

# Configures the endpoint
config :form_manager, FormManagerWeb.Endpoint,
  server: false,
  url: [host: "localhost"],
  secret_key_base: "EgW1n6hCS8EMI5Zhhy4yZSgTn5M3/lxpw4Ca0twb0R7/0nNVTkyGOAZtIYLyC6qj",
  render_errors: [view: FormManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: FormManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
