defmodule AssetManagerWeb.Router do
  use AssetManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AssetManagerWeb do
    pipe_through :api
  end
end
