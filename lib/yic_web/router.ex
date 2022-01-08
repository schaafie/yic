defmodule YicWeb.Router do
  use YicWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {YicWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", YicWeb do
    pipe_through :browser
    get "/", PageController, :index
  end

  scope "/html/iam", YicWeb.Html.Iam, as: :html_iam do
    pipe_through :browser

    resources "/users", UsersController
    resources "/roles", RolesController
    resources "/groups", GroupsController
    resources "/systems", SystemController
    resources "/actions", ActionController
    resources "/allows", AllowController
    resources "/denies", DenieController
  end

  scope "/html/forms", YicWeb.Html.Forms, as: :html_forms do
    pipe_through :browser
    
    resources "/forms", FormController
    resources "/datasources", DatasourceController
  end

  # Other scopes may use custom stacks.
  scope "/api/iam", YicWeb.Api.Iam, as: :api_iam do
    pipe_through :api

    resources "/users", UsersController
    resources "/roles", RolesController
    resources "/groups", GroupsController
    resources "/systems", SystemController
    resources "/actions", ActionController
    resources "/allows", AllowController
    resources "/denies", DenieController
  end

  scope "/api/forms", YicWeb.Api.Forms, as: :api_forms do 
    pipe_through :api                                     
                                                       
    resources "/forms", FormController
    resources "/datasources", DatasourceController                    
  end                                                     

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: YicWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
