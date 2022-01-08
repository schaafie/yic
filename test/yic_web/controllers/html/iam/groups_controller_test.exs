defmodule YicWeb.Html.Iam.GroupsControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  @create_attrs %{comment: "some comment", name: "some name"}
  @update_attrs %{comment: "some updated comment", name: "some updated name"}
  @invalid_attrs %{comment: nil, name: nil}

  describe "index" do
    test "lists all groups", %{conn: conn} do
      conn = get(conn, Routes.html_iam_groups_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Groups"
    end
  end

  describe "new groups" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_iam_groups_path(conn, :new))
      assert html_response(conn, 200) =~ "New Groups"
    end
  end

  describe "create groups" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_groups_path(conn, :create), groups: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_iam_groups_path(conn, :show, id)

      conn = get(conn, Routes.html_iam_groups_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Groups"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_groups_path(conn, :create), groups: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Groups"
    end
  end

  describe "edit groups" do
    setup [:create_groups]

    test "renders form for editing chosen groups", %{conn: conn, groups: groups} do
      conn = get(conn, Routes.html_iam_groups_path(conn, :edit, groups))
      assert html_response(conn, 200) =~ "Edit Groups"
    end
  end

  describe "update groups" do
    setup [:create_groups]

    test "redirects when data is valid", %{conn: conn, groups: groups} do
      conn = put(conn, Routes.html_iam_groups_path(conn, :update, groups), groups: @update_attrs)
      assert redirected_to(conn) == Routes.html_iam_groups_path(conn, :show, groups)

      conn = get(conn, Routes.html_iam_groups_path(conn, :show, groups))
      assert html_response(conn, 200) =~ "some updated comment"
    end

    test "renders errors when data is invalid", %{conn: conn, groups: groups} do
      conn = put(conn, Routes.html_iam_groups_path(conn, :update, groups), groups: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Groups"
    end
  end

  describe "delete groups" do
    setup [:create_groups]

    test "deletes chosen groups", %{conn: conn, groups: groups} do
      conn = delete(conn, Routes.html_iam_groups_path(conn, :delete, groups))
      assert redirected_to(conn) == Routes.html_iam_groups_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_iam_groups_path(conn, :show, groups))
      end
    end
  end

  defp create_groups(_) do
    groups = groups_fixture()
    %{groups: groups}
  end
end
