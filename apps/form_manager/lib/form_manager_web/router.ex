defmodule FormManagerWeb.Router do
  use FormManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FormManagerWeb do
    pipe_through :api
  end
end
