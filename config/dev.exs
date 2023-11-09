import Config

# Configure your database
config :yic, Yic.Repo,
  # username: "casaos",
  # password: "casaos",
  # hostname: "casaos",
  # username: "postgres",
  #  password: "postgres",
  #  hostname: "localhost",
  # database: "yic_dev",
  username: System.get_env("PGUSER", "postgres"),
  password: System.get_env("PGPASSWORD", "postgres"),
  database: System.get_env("PGDATABASE", "yic_dev"),
  hostname: System.get_env("PGHOST", "localhost"),
  port:     System.get_env("PGPORT", "5433"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :yic, YicWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "mHSKzvBEGnm6W5M5aqUmUtiQBJUI8MJryzlugyZnTASK2ZFRxS0icVikS84gefwg",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :yic, YicWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg|ttf)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/yic_web/(live|views)/.*(ex)$",
      ~r"lib/yic_web/templates/.*(eex)$"
    ]
  ]

  # Do not print debug messages in production
config :logger, level: :debug
# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "$metadata[$level] $message\n",
metadata: [:file, :line]

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
