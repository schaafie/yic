defmodule Api.Application do
  @moduledoc """
  The Api Application Service.

  The api system business domain lives in this application.

  Exposes API to clients such as the `ApiWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      
    ], strategy: :one_for_one, name: Api.Supervisor)
  end
end
