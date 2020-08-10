defmodule Yic.Application do
  @moduledoc """
  The Yic Application Service.

  The yic system business domain lives in this application.

  Exposes API to clients such as the `YicWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      
    ], strategy: :one_for_one, name: Yic.Supervisor)
  end
end
