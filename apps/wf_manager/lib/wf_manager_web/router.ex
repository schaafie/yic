defmodule WfManagerWeb.Router do
  use WfManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WfManagerWeb do
    pipe_through :api
  end
end
