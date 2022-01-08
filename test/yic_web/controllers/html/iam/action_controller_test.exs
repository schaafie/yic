defmodule YicWeb.Html.Iam.ActionControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  @create_attrs %{comment: "some comment", name: "some name", url: "some url"}
  @update_attrs %{comment: "some updated comment", name: "some updated name", url: "some updated url"}
  @invalid_attrs %{comment: nil, name: nil, url: nil}

  describe "index" do
    test "lists all actions", %{conn: conn} do
      conn = get(conn, Routes.html_iam_action_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Actions"
    end
  end

  describe "new action" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_iam_action_path(conn, :new))
      assert html_response(conn, 200) =~ "New Action"
    end
  end

  describe "create action" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_action_path(conn, :create), action: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_iam_action_path(conn, :show, id)

      conn = get(conn, Routes.html_iam_action_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Action"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_action_path(conn, :create), action: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Action"
    end
  end

  describe "edit action" do
    setup [:create_action]

    test "renders form for editing chosen action", %{conn: conn, action: action} do
      conn = get(conn, Routes.html_iam_action_path(conn, :edit, action))
      assert html_response(conn, 200) =~ "Edit Action"
    end
  end

  describe "update action" do
    setup [:create_action]

    test "redirects when data is valid", %{conn: conn, action: action} do
      conn = put(conn, Routes.html_iam_action_path(conn, :update, action), action: @update_attrs)
      assert redirected_to(conn) == Routes.html_iam_action_path(conn, :show, action)

      conn = get(conn, Routes.html_iam_action_path(conn, :show, action))
      assert html_response(conn, 200) =~ "some updated comment"
    end

    test "renders errors when data is invalid", %{conn: conn, action: action} do
      conn = put(conn, Routes.html_iam_action_path(conn, :update, action), action: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Action"
    end
  end

  describe "delete action" do
    setup [:create_action]

    test "deletes chosen action", %{conn: conn, action: action} do
      conn = delete(conn, Routes.html_iam_action_path(conn, :delete, action))
      assert redirected_to(conn) == Routes.html_iam_action_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_iam_action_path(conn, :show, action))
      end
    end
  end

  defp create_action(_) do
    action = action_fixture()
    %{action: action}
  end
end
