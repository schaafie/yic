defmodule YicWeb.Api.Apis.ApiController do
  use YicWeb, :controller

  alias Yic.Apis
  alias Yic.Apis.Api
  alias Yic.Apis.System


  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    apis = Apis.list_apis()
    render(conn, "index.json", apis: apis)
  end

  def create(conn, %{"api" => api_params}) do
    with {:ok, %Api{} = api} <- Apis.create_api(api_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_apis_api_path(conn, :show, api))
      |> render("show.json", api: api)
    end
  end

  def show(conn, %{"id" => id}) do
    api = Apis.get_api!(id)
    render(conn, "show.json", api: api)
  end

  def update(conn, %{"id" => id, "api" => api_params}) do
    api = Apis.get_api!(id)

    with {:ok, %Api{} = api} <- Apis.update_api(api, api_params) do
      render(conn, "show.json", api: api)
    end
  end

  def delete(conn, %{"id" => id}) do
    api = Apis.get_api!(id)

    with {:ok, %Api{}} <- Apis.delete_api(api) do
      send_resp(conn, :no_content, "")
    end
  end

  def handle(conn, %{"path" => path}) do
    case Apis.match_call( path ) do
      {:ok, definition} ->
        data = handle(definition)
        render(conn, "respons.json", data: data )
      :nok ->
        render(conn, "respons.json", data: [])
    end
  end

  defp handle(def) do
    {:ok, def_map} = Poison.decode(def)
    tasks = Enum.map( def_map["actions"], fn(task) ->
      url = task["url"]
      method = task["method"]
      token = task["token"]
      output = task["output"]
      Task.async( System, :call, [method, url, token, output ] )
    end )

    results = Task.await_many(tasks)

    define_respons results, def_map["output"]
  end

  def define_respons( [], output ) do
    output
  end

  def define_respons [item|list], output do
    IO.inspect output
    case item do
      {:ok, %{key: key, value: data }} ->
        respons = Map.replace( output, key, data )
        define_respons list, respons
      {:error, %{msg: msg, key: key}} ->
        error = "Error found on key #{key} with error message #{msg}"
        %{error: error}
    end
  end
end
