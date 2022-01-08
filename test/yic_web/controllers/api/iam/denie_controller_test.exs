defmodule YicWeb.Api.Iam.DenieControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  alias Yic.Iam.Denie

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all denies", %{conn: conn} do
      conn = get(conn, Routes.api_iam_denie_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create denie" do
    test "renders denie when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_denie_path(conn, :create), denie: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_iam_denie_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_denie_path(conn, :create), denie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update denie" do
    setup [:create_denie]

    test "renders denie when data is valid", %{conn: conn, denie: %Denie{id: id} = denie} do
      conn = put(conn, Routes.api_iam_denie_path(conn, :update, denie), denie: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_iam_denie_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, denie: denie} do
      conn = put(conn, Routes.api_iam_denie_path(conn, :update, denie), denie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete denie" do
    setup [:create_denie]

    test "deletes chosen denie", %{conn: conn, denie: denie} do
      conn = delete(conn, Routes.api_iam_denie_path(conn, :delete, denie))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_iam_denie_path(conn, :show, denie))
      end
    end
  end

  defp create_denie(_) do
    denie = denie_fixture()
    %{denie: denie}
  end
end
