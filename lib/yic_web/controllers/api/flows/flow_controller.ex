defmodule YicWeb.Api.Flows.FlowController do
  use YicWeb, :controller

  alias Yic.Flows
  alias Yic.Flows.Flow

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    flows = Flows.list_flows()
    render(conn, "index.json", flows: flows)
  end

  def create(conn, %{"flow" => flow_params}) do
    with {:ok, %Flow{} = flow} <- Flows.create_flow(flow_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_flows_flow_path(conn, :show, flow))
      |> render("show.json", flow: flow)
    end
  end

  def show(conn, %{"id" => id}) do
    flow = Flows.get_flow!(id)
    render(conn, "show.json", flow: flow)
  end

  def update(conn, %{"id" => id, "flow" => flow_params}) do
    flow = Flows.get_flow!(id)

    with {:ok, %Flow{} = flow} <- Flows.update_flow(flow, flow_params) do
      render(conn, "show.json", flow: flow)
    end
  end

  def delete(conn, %{"id" => id}) do
    flow = Flows.get_flow!(id)

    with {:ok, %Flow{}} <- Flows.delete_flow(flow) do
      send_resp(conn, :no_content, "")
    end
  end
end
