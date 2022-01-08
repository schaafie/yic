defmodule YicWeb.Html.Iam.DenieControllerTest do
  use YicWeb.ConnCase

  import Yic.IamFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all denies", %{conn: conn} do
      conn = get(conn, Routes.html_iam_denie_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Denies"
    end
  end

  describe "new denie" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_iam_denie_path(conn, :new))
      assert html_response(conn, 200) =~ "New Denie"
    end
  end

  describe "create denie" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_denie_path(conn, :create), denie: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_iam_denie_path(conn, :show, id)

      conn = get(conn, Routes.html_iam_denie_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Denie"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_iam_denie_path(conn, :create), denie: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Denie"
    end
  end

  describe "edit denie" do
    setup [:create_denie]

    test "renders form for editing chosen denie", %{conn: conn, denie: denie} do
      conn = get(conn, Routes.html_iam_denie_path(conn, :edit, denie))
      assert html_response(conn, 200) =~ "Edit Denie"
    end
  end

  describe "update denie" do
    setup [:create_denie]

    test "redirects when data is valid", %{conn: conn, denie: denie} do
      conn = put(conn, Routes.html_iam_denie_path(conn, :update, denie), denie: @update_attrs)
      assert redirected_to(conn) == Routes.html_iam_denie_path(conn, :show, denie)

      conn = get(conn, Routes.html_iam_denie_path(conn, :show, denie))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, denie: denie} do
      conn = put(conn, Routes.html_iam_denie_path(conn, :update, denie), denie: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Denie"
    end
  end

  describe "delete denie" do
    setup [:create_denie]

    test "deletes chosen denie", %{conn: conn, denie: denie} do
      conn = delete(conn, Routes.html_iam_denie_path(conn, :delete, denie))
      assert redirected_to(conn) == Routes.html_iam_denie_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_iam_denie_path(conn, :show, denie))
      end
    end
  end

  defp create_denie(_) do
    denie = denie_fixture()
    %{denie: denie}
  end
end
