defmodule FormManagerWeb.Router do
  use FormManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FormManagerWeb do
    pipe_through :api

    resources "/forms", FormController, except: [:new, :edit]
    resources "/datasources", DatasourceController, except: [:new, :edit]    
  end
end
