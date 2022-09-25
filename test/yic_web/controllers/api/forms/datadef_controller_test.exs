defmodule YicWeb.Api.Forms.DatadefControllerTest do
  use YicWeb.ConnCase

  import Yic.FormsFixtures

  alias Yic.Forms.Datadef

  @create_attrs %{
    comment: "some comment",
    definition: %{},
    name: "some name",
    version: "some version"
  }
  @update_attrs %{
    comment: "some updated comment",
    definition: %{},
    name: "some updated name",
    version: "some updated version"
  }
  @invalid_attrs %{comment: nil, definition: nil, name: nil, version: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all datadefs", %{conn: conn} do
      conn = get(conn, Routes.api_forms_datadef_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create datadef" do
    test "renders datadef when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_forms_datadef_path(conn, :create), datadef: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_forms_datadef_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comment" => "some comment",
               "definition" => %{},
               "name" => "some name",
               "version" => "some version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_forms_datadef_path(conn, :create), datadef: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update datadef" do
    setup [:create_datadef]

    test "renders datadef when data is valid", %{conn: conn, datadef: %Datadef{id: id} = datadef} do
      conn = put(conn, Routes.api_forms_datadef_path(conn, :update, datadef), datadef: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_forms_datadef_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comment" => "some updated comment",
               "definition" => %{},
               "name" => "some updated name",
               "version" => "some updated version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, datadef: datadef} do
      conn = put(conn, Routes.api_forms_datadef_path(conn, :update, datadef), datadef: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete datadef" do
    setup [:create_datadef]

    test "deletes chosen datadef", %{conn: conn, datadef: datadef} do
      conn = delete(conn, Routes.api_forms_datadef_path(conn, :delete, datadef))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_forms_datadef_path(conn, :show, datadef))
      end
    end
  end

  defp create_datadef(_) do
    datadef = datadef_fixture()
    %{datadef: datadef}
  end
end
