defmodule YicWeb.Html.Iam.UsersControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  @create_attrs %{email: "some email", firstname: "some firstname", lastname: "some lastname"}
  @update_attrs %{email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname"}
  @invalid_attrs %{email: nil, firstname: nil, lastname: nil}

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.html_iam_users_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new users" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_iam_users_path(conn, :new))
      assert html_response(conn, 200) =~ "New Users"
    end
  end

  describe "create users" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_users_path(conn, :create), users: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_iam_users_path(conn, :show, id)

      conn = get(conn, Routes.html_iam_users_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Users"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_users_path(conn, :create), users: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Users"
    end
  end

  describe "edit users" do
    setup [:create_users]

    test "renders form for editing chosen users", %{conn: conn, users: users} do
      conn = get(conn, Routes.html_iam_users_path(conn, :edit, users))
      assert html_response(conn, 200) =~ "Edit Users"
    end
  end

  describe "update users" do
    setup [:create_users]

    test "redirects when data is valid", %{conn: conn, users: users} do
      conn = put(conn, Routes.html_iam_users_path(conn, :update, users), users: @update_attrs)
      assert redirected_to(conn) == Routes.html_iam_users_path(conn, :show, users)

      conn = get(conn, Routes.html_iam_users_path(conn, :show, users))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, users: users} do
      conn = put(conn, Routes.html_iam_users_path(conn, :update, users), users: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Users"
    end
  end

  describe "delete users" do
    setup [:create_users]

    test "deletes chosen users", %{conn: conn, users: users} do
      conn = delete(conn, Routes.html_iam_users_path(conn, :delete, users))
      assert redirected_to(conn) == Routes.html_iam_users_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_iam_users_path(conn, :show, users))
      end
    end
  end

  defp create_users(_) do
    users = users_fixture()
    %{users: users}
  end
end
