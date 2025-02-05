defmodule YicWeb.Html.Flows.FlowController do
  use YicWeb, :controller

  alias Yic.Flows
  alias Yic.Flows.Flow

  def index(conn, _params) do
    flows = Flows.list_flows()
    render(conn, "index.html", flows: flows)
  end

  def new(conn, _params) do
    changeset = Flows.change_flow(%Flow{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"flow" => flow_params}) do
    case Flows.create_flow(flow_params) do
      {:ok, flow} ->
        conn
        |> put_flash(:info, "Flow created successfully.")
        |> redirect(to: Routes.html_flows_flow_path(conn, :show, flow))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    flow = Flows.get_flow!(id)
    render(conn, "show.html", flow: flow)
  end

  def edit(conn, %{"id" => id}) do
    flow = Flows.get_flow!(id)
    changeset = Flows.change_flow(flow)
    render(conn, "edit.html", flow: flow, changeset: changeset)
  end

  def update(conn, %{"id" => id, "flow" => flow_params}) do
    flow = Flows.get_flow!(id)

    case Flows.update_flow(flow, flow_params) do
      {:ok, flow} ->
        conn
        |> put_flash(:info, "Flow updated successfully.")
        |> redirect(to: Routes.html_flows_flow_path(conn, :show, flow))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", flow: flow, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    flow = Flows.get_flow!(id)
    {:ok, _flow} = Flows.delete_flow(flow)

    conn
    |> put_flash(:info, "Flow deleted successfully.")
    |> redirect(to: Routes.html_flows_flow_path(conn, :index))
  end
end
