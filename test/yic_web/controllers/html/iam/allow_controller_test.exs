defmodule YicWeb.Html.Iam.AllowControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all allows", %{conn: conn} do
      conn = get(conn, Routes.html_iam_allow_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Allows"
    end
  end

  describe "new allow" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_iam_allow_path(conn, :new))
      assert html_response(conn, 200) =~ "New Allow"
    end
  end

  describe "create allow" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_allow_path(conn, :create), allow: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_iam_allow_path(conn, :show, id)

      conn = get(conn, Routes.html_iam_allow_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Allow"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_allow_path(conn, :create), allow: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Allow"
    end
  end

  describe "edit allow" do
    setup [:create_allow]

    test "renders form for editing chosen allow", %{conn: conn, allow: allow} do
      conn = get(conn, Routes.html_iam_allow_path(conn, :edit, allow))
      assert html_response(conn, 200) =~ "Edit Allow"
    end
  end

  describe "update allow" do
    setup [:create_allow]

    test "redirects when data is valid", %{conn: conn, allow: allow} do
      conn = put(conn, Routes.html_iam_allow_path(conn, :update, allow), allow: @update_attrs)
      assert redirected_to(conn) == Routes.html_iam_allow_path(conn, :show, allow)

      conn = get(conn, Routes.html_iam_allow_path(conn, :show, allow))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, allow: allow} do
      conn = put(conn, Routes.html_iam_allow_path(conn, :update, allow), allow: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Allow"
    end
  end

  describe "delete allow" do
    setup [:create_allow]

    test "deletes chosen allow", %{conn: conn, allow: allow} do
      conn = delete(conn, Routes.html_iam_allow_path(conn, :delete, allow))
      assert redirected_to(conn) == Routes.html_iam_allow_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_iam_allow_path(conn, :show, allow))
      end
    end
  end

  defp create_allow(_) do
    allow = allow_fixture()
    %{allow: allow}
  end
end
