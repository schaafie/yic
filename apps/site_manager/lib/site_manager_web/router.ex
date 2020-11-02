defmodule SiteManagerWeb.Router do
  use SiteManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SiteManagerWeb do
    pipe_through :api
  end
end
