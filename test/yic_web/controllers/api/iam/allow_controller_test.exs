defmodule YicWeb.Api.Iam.AllowControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  alias Yic.Iam.Allow

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all allows", %{conn: conn} do
      conn = get(conn, Routes.api_iam_allow_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create allow" do
    test "renders allow when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_allow_path(conn, :create), allow: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_iam_allow_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_allow_path(conn, :create), allow: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update allow" do
    setup [:create_allow]

    test "renders allow when data is valid", %{conn: conn, allow: %Allow{id: id} = allow} do
      conn = put(conn, Routes.api_iam_allow_path(conn, :update, allow), allow: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_iam_allow_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, allow: allow} do
      conn = put(conn, Routes.api_iam_allow_path(conn, :update, allow), allow: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete allow" do
    setup [:create_allow]

    test "deletes chosen allow", %{conn: conn, allow: allow} do
      conn = delete(conn, Routes.api_iam_allow_path(conn, :delete, allow))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_iam_allow_path(conn, :show, allow))
      end
    end
  end

  defp create_allow(_) do
    allow = allow_fixture()
    %{allow: allow}
  end
end
