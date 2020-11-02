# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wf_manager,
  namespace: WfManager,
  ecto_repos: [WfManager.Repo]

# Configures the endpoint
config :wf_manager, WfManagerWeb.Endpoint,
  server: false,
  url: [host: "localhost"],
  secret_key_base: "1ZZbynlNiGV+o75kamGmNfqInjYxNTLU54ByBZhEri9UsqP+u8lR4d5X8969TX4o",
  render_errors: [view: WfManagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: WfManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
