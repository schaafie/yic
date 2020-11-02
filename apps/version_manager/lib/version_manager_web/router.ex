defmodule VersionManagerWeb.Router do
  use VersionManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VersionManagerWeb do
    pipe_through :api
  end
end
