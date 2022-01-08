defmodule YicWeb.Html.Iam.RolesControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  describe "index" do
    test "lists all roles", %{conn: conn} do
      conn = get(conn, Routes.html_iam_roles_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Roles"
    end
  end

  describe "new roles" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_iam_roles_path(conn, :new))
      assert html_response(conn, 200) =~ "New Roles"
    end
  end

  describe "create roles" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_roles_path(conn, :create), roles: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_iam_roles_path(conn, :show, id)

      conn = get(conn, Routes.html_iam_roles_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Roles"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_roles_path(conn, :create), roles: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Roles"
    end
  end

  describe "edit roles" do
    setup [:create_roles]

    test "renders form for editing chosen roles", %{conn: conn, roles: roles} do
      conn = get(conn, Routes.html_iam_roles_path(conn, :edit, roles))
      assert html_response(conn, 200) =~ "Edit Roles"
    end
  end

  describe "update roles" do
    setup [:create_roles]

    test "redirects when data is valid", %{conn: conn, roles: roles} do
      conn = put(conn, Routes.html_iam_roles_path(conn, :update, roles), roles: @update_attrs)
      assert redirected_to(conn) == Routes.html_iam_roles_path(conn, :show, roles)

      conn = get(conn, Routes.html_iam_roles_path(conn, :show, roles))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, roles: roles} do
      conn = put(conn, Routes.html_iam_roles_path(conn, :update, roles), roles: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Roles"
    end
  end

  describe "delete roles" do
    setup [:create_roles]

    test "deletes chosen roles", %{conn: conn, roles: roles} do
      conn = delete(conn, Routes.html_iam_roles_path(conn, :delete, roles))
      assert redirected_to(conn) == Routes.html_iam_roles_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_iam_roles_path(conn, :show, roles))
      end
    end
  end

  defp create_roles(_) do
    roles = roles_fixture()
    %{roles: roles}
  end
end
