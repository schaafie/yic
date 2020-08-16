defmodule ApiWeb.ApiController do
  use ApiWeb, :controller

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", users: [])
  end

end
