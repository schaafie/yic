defmodule PublicationManagerWeb.Router do
  use PublicationManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PublicationManagerWeb do
    pipe_through :api

    get "/publications/byname", PublicationController, :getbyname
    resources "/publications", PublicationController, except: [:new, :edit]

  end
end
