defmodule ApiManagerWeb.Router do
  use ApiManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiManagerWeb do
    pipe_through :api
  end
end
