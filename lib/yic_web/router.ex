defmodule YicWeb.Router do
  use YicWeb, :router

  import YicWeb.Html.Iam.AccountAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {YicWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_account
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_authenticated do
    plug :accepts, ["json"]
    plug YicWeb.AuthAccessPipeline
    plug :fetch_current_account_api
  end

  pipeline :static do
    plug Plug.Static, 
      at: "/", 
      from: { :yic, "priv/html" }
  end  

  scope "/api", YicWeb.Api.Iam, as: :api_iam do
    pipe_through :api
    
    get "/refresh", SessionController, :refresh
    get "/restore", SessionController, :restore
    post "/sign_in", SessionController, :create
  end

  scope "/", YicWeb do
    pipe_through [:browser, :require_authenticated_account]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/iam", YicWeb.Api.Iam, as: :api_iam do
    pipe_through :api_authenticated

    resources "/users", UsersController
    resources "/roles", RolesController
    resources "/groups", GroupsController
    resources "/systems", SystemController
    resources "/actions", ActionController
    resources "/allows", AllowController
    resources "/denies", DenieController
  end

  scope "/api/forms", YicWeb.Api.Forms, as: :api_forms do 
    pipe_through :api_authenticated                                     
                                                       
    get "/formbyname/:name", FormController, :show
    get "/datadefbyname/:name", DatadefController, :show
    resources "/forms", FormController
    resources "/datasources", DatasourceController
    resources "/datadefs", DatadefController
  end
  
  scope "/api/content", YicWeb.Api.Content, as: :api_content do 
    pipe_through :api_authenticated           

    resources "/templates", TemplateController
    resources "/items", ItemController
  end

  scope "/api/apis", YicWeb.Api.Apis, as: :api_apis do
    pipe_through :api_authenticated                                     

    resources "/apis", ApiController
  end

  # API Handler through api manager
  #
  scope "/api/orchestrator", YicWeb.Api.Apis, as: :api_apis do
    pipe_through :api_authenticated
    
    get "/*path", ApiController, :handle
    post "/*path", ApiController, :handle
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

  ## Authentication routes

  scope "/html/iam", YicWeb.Html.Iam, as: :html_iam do
    pipe_through [:browser, :redirect_if_account_is_authenticated]

    get "/accounts/register", AccountRegistrationController, :new
    post "/accounts/register", AccountRegistrationController, :create
    get "/accounts/log_in", AccountSessionController, :new
    post "/accounts/log_in", AccountSessionController, :create
    get "/accounts/reset_password", AccountResetPasswordController, :new
    post "/accounts/reset_password", AccountResetPasswordController, :create
    get "/accounts/reset_password/:token", AccountResetPasswordController, :edit
    put "/accounts/reset_password/:token", AccountResetPasswordController, :update
  end

  scope "/html/iam", YicWeb.Html.Iam, as: :html_iam do
    pipe_through [:browser]

    delete "/accounts/log_out", AccountSessionController, :delete
    get "/accounts/confirm", AccountConfirmationController, :new
    post "/accounts/confirm", AccountConfirmationController, :create
    get "/accounts/confirm/:token", AccountConfirmationController, :edit
    post "/accounts/confirm/:token", AccountConfirmationController, :update
  end

  scope "/html/iam", YicWeb.Html.Iam, as: :html_iam do
    pipe_through [:browser, :require_authenticated_account]

    get "/accounts/settings", AccountSettingsController, :edit
    put "/accounts/settings", AccountSettingsController, :update
    get "/accounts/settings/confirm_email/:token", AccountSettingsController, :confirm_email
    resources "/users", UsersController
    resources "/accounts", AccountController
    resources "/roles", RolesController
    resources "/groups", GroupsController
    resources "/systems", SystemController
    resources "/actions", ActionController
    resources "/allows", AllowController
    resources "/denies", DenieController
  end

  scope "/html/forms", YicWeb.Html.Forms, as: :html_forms do
    pipe_through [:browser, :require_authenticated_account]
    
    resources "/forms", FormController
    resources "/datasources", DatasourceController
    resources "/datadefs", DatadefController
  end

  scope "/html/content", YicWeb.Html.Content, as: :html_content do
    pipe_through [:browser, :require_authenticated_account]

    resources "/templates", TemplateController
    resources "/items", ItemController
  end

  scope "/html/apis", YicWeb.Html.Apis, as: :html_apis do
    pipe_through [:browser, :require_authenticated_account]
    resources "/apis", ApiController
  end

  scope "/", YicWeb do
    pipe_through :static
    get "/*path", PageController, :notfound
  end

end
