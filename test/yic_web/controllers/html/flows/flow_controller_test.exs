defmodule YicWeb.Html.Flows.FlowControllerTest do
  use YicWeb.ConnCase

  import Yic.FlowsFixtures

  @create_attrs %{can_start: %{}, definition: %{}, description: "some description", name: "some name", version: %{}}
  @update_attrs %{can_start: %{}, definition: %{}, description: "some updated description", name: "some updated name", version: %{}}
  @invalid_attrs %{can_start: nil, definition: nil, description: nil, name: nil, version: nil}

  describe "index" do
    test "lists all flows", %{conn: conn} do
      conn = get(conn, Routes.html_flows_flow_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Flows"
    end
  end

  describe "new flow" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_flows_flow_path(conn, :new))
      assert html_response(conn, 200) =~ "New Flow"
    end
  end

  describe "create flow" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_flows_flow_path(conn, :create), flow: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_flows_flow_path(conn, :show, id)

      conn = get(conn, Routes.html_flows_flow_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Flow"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_flows_flow_path(conn, :create), flow: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Flow"
    end
  end

  describe "edit flow" do
    setup [:create_flow]

    test "renders form for editing chosen flow", %{conn: conn, flow: flow} do
      conn = get(conn, Routes.html_flows_flow_path(conn, :edit, flow))
      assert html_response(conn, 200) =~ "Edit Flow"
    end
  end

  describe "update flow" do
    setup [:create_flow]

    test "redirects when data is valid", %{conn: conn, flow: flow} do
      conn = put(conn, Routes.html_flows_flow_path(conn, :update, flow), flow: @update_attrs)
      assert redirected_to(conn) == Routes.html_flows_flow_path(conn, :show, flow)

      conn = get(conn, Routes.html_flows_flow_path(conn, :show, flow))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, flow: flow} do
      conn = put(conn, Routes.html_flows_flow_path(conn, :update, flow), flow: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Flow"
    end
  end

  describe "delete flow" do
    setup [:create_flow]

    test "deletes chosen flow", %{conn: conn, flow: flow} do
      conn = delete(conn, Routes.html_flows_flow_path(conn, :delete, flow))
      assert redirected_to(conn) == Routes.html_flows_flow_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_flows_flow_path(conn, :show, flow))
      end
    end
  end

  defp create_flow(_) do
    flow = flow_fixture()
    %{flow: flow}
  end
end
