defmodule YicWeb.PageController do
  use YicWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
  
  def notfound(conn, _params) do
    redirect(conn, to: "/404.html")
  end

end
