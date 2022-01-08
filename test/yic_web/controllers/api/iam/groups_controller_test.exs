defmodule YicWeb.Api.Iam.GroupsControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  alias Yic.Iam.Groups

  @create_attrs %{
    comment: "some comment",
    name: "some name"
  }
  @update_attrs %{
    comment: "some updated comment",
    name: "some updated name"
  }
  @invalid_attrs %{comment: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all groups", %{conn: conn} do
      conn = get(conn, Routes.api_iam_groups_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create groups" do
    test "renders groups when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_groups_path(conn, :create), groups: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_iam_groups_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comment" => "some comment",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_groups_path(conn, :create), groups: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update groups" do
    setup [:create_groups]

    test "renders groups when data is valid", %{conn: conn, groups: %Groups{id: id} = groups} do
      conn = put(conn, Routes.api_iam_groups_path(conn, :update, groups), groups: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_iam_groups_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "comment" => "some updated comment",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, groups: groups} do
      conn = put(conn, Routes.api_iam_groups_path(conn, :update, groups), groups: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete groups" do
    setup [:create_groups]

    test "deletes chosen groups", %{conn: conn, groups: groups} do
      conn = delete(conn, Routes.api_iam_groups_path(conn, :delete, groups))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_iam_groups_path(conn, :show, groups))
      end
    end
  end

  defp create_groups(_) do
    groups = groups_fixture()
    %{groups: groups}
  end
end
