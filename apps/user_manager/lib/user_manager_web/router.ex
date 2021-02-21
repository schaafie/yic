defmodule UserManagerWeb.Router do
  use UserManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UserManagerWeb do
    pipe_through :api
    
    resources "/users", UserController, except: [:new, :edit]
    get "/users/definition", UserController, :definition
    
  end
end
