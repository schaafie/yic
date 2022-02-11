defmodule YicWeb.Api.Apis.ApiControllerTest do
  use YicWeb.ConnCase

  import Yic.ApisFixtures

  alias Yic.Apis.Api

  @create_attrs %{
    definition: "some definition",
    description: "some description",
    name: "some name",
    request: "some request",
    version: "some version"
  }
  @update_attrs %{
    definition: "some updated definition",
    description: "some updated description",
    name: "some updated name",
    request: "some updated request",
    version: "some updated version"
  }
  @invalid_attrs %{definition: nil, description: nil, name: nil, request: nil, version: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all apis", %{conn: conn} do
      conn = get(conn, Routes.api_apis_api_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create api" do
    test "renders api when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_apis_api_path(conn, :create), api: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_apis_api_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "definition" => "some definition",
               "description" => "some description",
               "name" => "some name",
               "request" => "some request",
               "version" => "some version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_apis_api_path(conn, :create), api: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update api" do
    setup [:create_api]

    test "renders api when data is valid", %{conn: conn, api: %Api{id: id} = api} do
      conn = put(conn, Routes.api_apis_api_path(conn, :update, api), api: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_apis_api_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "definition" => "some updated definition",
               "description" => "some updated description",
               "name" => "some updated name",
               "request" => "some updated request",
               "version" => "some updated version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, api: api} do
      conn = put(conn, Routes.api_apis_api_path(conn, :update, api), api: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete api" do
    setup [:create_api]

    test "deletes chosen api", %{conn: conn, api: api} do
      conn = delete(conn, Routes.api_apis_api_path(conn, :delete, api))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_apis_api_path(conn, :show, api))
      end
    end
  end

  defp create_api(_) do
    api = api_fixture()
    %{api: api}
  end
end
