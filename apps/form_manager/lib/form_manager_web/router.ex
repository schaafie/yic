defmodule FormManagerWeb.Router do
  use FormManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FormManagerWeb do
    pipe_through :api

    get "/definition", FormController, :definition
    resources "/forms", FormController, except: [:new, :edit]
  end
end
