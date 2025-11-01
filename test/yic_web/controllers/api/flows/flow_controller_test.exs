defmodule YicWeb.Api.Flows.FlowControllerTest do
  use YicWeb.ConnCase

  import Yic.FlowsFixtures

  alias Yic.Flows.Flow

  @create_attrs %{
    can_start: %{},
    definition: %{},
    description: "some description",
    name: "some name",
    version: %{}
  }
  @update_attrs %{
    can_start: %{},
    definition: %{},
    description: "some updated description",
    name: "some updated name",
    version: %{}
  }
  @invalid_attrs %{can_start: nil, definition: nil, description: nil, name: nil, version: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all flows", %{conn: conn} do
      conn = get(conn, Routes.api_flows_flow_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create flow" do
    test "renders flow when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_flows_flow_path(conn, :create), flow: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_flows_flow_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "can_start" => %{},
               "definition" => %{},
               "description" => "some description",
               "name" => "some name",
               "version" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_flows_flow_path(conn, :create), flow: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update flow" do
    setup [:create_flow]

    test "renders flow when data is valid", %{conn: conn, flow: %Flow{id: id} = flow} do
      conn = put(conn, Routes.api_flows_flow_path(conn, :update, flow), flow: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_flows_flow_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "can_start" => %{},
               "definition" => %{},
               "description" => "some updated description",
               "name" => "some updated name",
               "version" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, flow: flow} do
      conn = put(conn, Routes.api_flows_flow_path(conn, :update, flow), flow: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete flow" do
    setup [:create_flow]

    test "deletes chosen flow", %{conn: conn, flow: flow} do
      conn = delete(conn, Routes.api_flows_flow_path(conn, :delete, flow))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_flows_flow_path(conn, :show, flow))
      end
    end
  end

  defp create_flow(_) do
    flow = flow_fixture()
    %{flow: flow}
  end
end
