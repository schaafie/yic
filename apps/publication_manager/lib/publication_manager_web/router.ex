defmodule PublicationManagerWeb.Router do
  use PublicationManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PublicationManagerWeb do
    pipe_through :api
  end
end
