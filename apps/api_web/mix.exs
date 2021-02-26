defmodule ApiWeb.Mixfile do
  use Mix.Project

  def project do
    [
      app: :api_web,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ApiWeb.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:api, in_umbrella: true},
      {:version_manager, in_umbrella: true},
      {:ia_manager, in_umbrella: true},
      {:user_manager, in_umbrella: true},
      {:asset_manager, in_umbrella: true},
      {:content_manager, in_umbrella: true},
      {:form_manager, in_umbrella: true},
      {:site_manager, in_umbrella: true},
      {:wf_manager, in_umbrella: true},
      {:publication_manager, in_umbrella: true},
      {:api_manager, in_umbrella: true},
      {:phoenix, "~> 1.3.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:api, in_umbrella: true},
      {:cowboy, "~> 1.0"},
      {:plug_cowboy, "~> 1.0"},
      {:cors_plug, "~> 1.5"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    []
  end
end
