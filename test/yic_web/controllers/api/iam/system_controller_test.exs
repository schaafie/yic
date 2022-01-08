defmodule YicWeb.Api.Iam.SystemControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  alias Yic.Iam.System

  @create_attrs %{
    comment: "some comment",
    host: "some host",
    name: "some name"
  }
  @update_attrs %{
    comment: "some updated comment",
    host: "some updated host",
    name: "some updated name"
  }
  @invalid_attrs %{comment: nil, host: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all systems", %{conn: conn} do
      conn = get(conn, Routes.api_iam_system_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create system" do
    test "renders system when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_system_path(conn, :create), system: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_iam_system_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comment" => "some comment",
               "host" => "some host",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_system_path(conn, :create), system: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update system" do
    setup [:create_system]

    test "renders system when data is valid", %{conn: conn, system: %System{id: id} = system} do
      conn = put(conn, Routes.api_iam_system_path(conn, :update, system), system: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_iam_system_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comment" => "some updated comment",
               "host" => "some updated host",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, system: system} do
      conn = put(conn, Routes.api_iam_system_path(conn, :update, system), system: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete system" do
    setup [:create_system]

    test "deletes chosen system", %{conn: conn, system: system} do
      conn = delete(conn, Routes.api_iam_system_path(conn, :delete, system))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_iam_system_path(conn, :show, system))
      end
    end
  end

  defp create_system(_) do
    system = system_fixture()
    %{system: system}
  end
end
