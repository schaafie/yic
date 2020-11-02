defmodule ContentManagerWeb.Router do
  use ContentManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ContentManagerWeb do
    pipe_through :api
  end
end
