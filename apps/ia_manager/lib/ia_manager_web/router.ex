defmodule IaManagerWeb.Router do
  use IaManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", IaManagerWeb do
    pipe_through :api
  end
end
