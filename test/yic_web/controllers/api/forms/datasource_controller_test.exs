defmodule YicWeb.Api.Forms.DatasourceControllerTest do
  use YicWeb.ConnCase

  import Yic.FormsFixtures

  alias Yic.Forms.Datasource

  @create_attrs %{
    actions: [],
    comment: "some comment",
    definition: "some definition",
    name: "some name",
    version: "some version"
  }
  @update_attrs %{
    actions: [],
    comment: "some updated comment",
    definition: "some updated definition",
    name: "some updated name",
    version: "some updated version"
  }
  @invalid_attrs %{actions: nil, comment: nil, definition: nil, name: nil, version: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all datasources", %{conn: conn} do
      conn = get(conn, Routes.api_forms_datasource_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create datasource" do
    test "renders datasource when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_forms_datasource_path(conn, :create), datasource: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_forms_datasource_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "actions" => [],
               "comment" => "some comment",
               "definition" => "some definition",
               "name" => "some name",
               "version" => "some version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_forms_datasource_path(conn, :create), datasource: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update datasource" do
    setup [:create_datasource]

    test "renders datasource when data is valid", %{conn: conn, datasource: %Datasource{id: id} = datasource} do
      conn = put(conn, Routes.api_forms_datasource_path(conn, :update, datasource), datasource: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_forms_datasource_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "actions" => [],
               "comment" => "some updated comment",
               "definition" => "some updated definition",
               "name" => "some updated name",
               "version" => "some updated version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, datasource: datasource} do
      conn = put(conn, Routes.api_forms_datasource_path(conn, :update, datasource), datasource: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete datasource" do
    setup [:create_datasource]

    test "deletes chosen datasource", %{conn: conn, datasource: datasource} do
      conn = delete(conn, Routes.api_forms_datasource_path(conn, :delete, datasource))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_forms_datasource_path(conn, :show, datasource))
      end
    end
  end

  defp create_datasource(_) do
    datasource = datasource_fixture()
    %{datasource: datasource}
  end
end
