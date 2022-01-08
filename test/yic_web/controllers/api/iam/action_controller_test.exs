defmodule YicWeb.Api.Iam.ActionControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  alias Yic.Iam.Action

  @create_attrs %{
    comment: "some comment",
    name: "some name",
    url: "some url"
  }
  @update_attrs %{
    comment: "some updated comment",
    name: "some updated name",
    url: "some updated url"
  }
  @invalid_attrs %{comment: nil, name: nil, url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all actions", %{conn: conn} do
      conn = get(conn, Routes.api_iam_action_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create action" do
    test "renders action when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_action_path(conn, :create), action: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_iam_action_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comment" => "some comment",
               "name" => "some name",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_action_path(conn, :create), action: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update action" do
    setup [:create_action]

    test "renders action when data is valid", %{conn: conn, action: %Action{id: id} = action} do
      conn = put(conn, Routes.api_iam_action_path(conn, :update, action), action: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_iam_action_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comment" => "some updated comment",
               "name" => "some updated name",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, action: action} do
      conn = put(conn, Routes.api_iam_action_path(conn, :update, action), action: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete action" do
    setup [:create_action]

    test "deletes chosen action", %{conn: conn, action: action} do
      conn = delete(conn, Routes.api_iam_action_path(conn, :delete, action))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_iam_action_path(conn, :show, action))
      end
    end
  end

  defp create_action(_) do
    action = action_fixture()
    %{action: action}
  end
end
