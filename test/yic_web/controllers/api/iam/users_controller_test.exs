defmodule YicWeb.Api.Iam.UsersControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  alias Yic.Iam.Users

  @create_attrs %{
    email: "some email",
    firstname: "some firstname",
    lastname: "some lastname"
  }
  @update_attrs %{
    email: "some updated email",
    firstname: "some updated firstname",
    lastname: "some updated lastname"
  }
  @invalid_attrs %{email: nil, firstname: nil, lastname: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.api_iam_users_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create users" do
    test "renders users when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_users_path(conn, :create), users: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_iam_users_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some email",
               "firstname" => "some firstname",
               "lastname" => "some lastname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_iam_users_path(conn, :create), users: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update users" do
    setup [:create_users]

    test "renders users when data is valid", %{conn: conn, users: %Users{id: id} = users} do
      conn = put(conn, Routes.api_iam_users_path(conn, :update, users), users: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_iam_users_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "firstname" => "some updated firstname",
               "lastname" => "some updated lastname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, users: users} do
      conn = put(conn, Routes.api_iam_users_path(conn, :update, users), users: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete users" do
    setup [:create_users]

    test "deletes chosen users", %{conn: conn, users: users} do
      conn = delete(conn, Routes.api_iam_users_path(conn, :delete, users))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_iam_users_path(conn, :show, users))
      end
    end
  end

  defp create_users(_) do
    users = users_fixture()
    %{users: users}
  end
end
