defmodule YicWeb.Html.Forms.DatadefControllerTest do
  use YicWeb.ConnCase

  import Yic.FormsFixtures

  @create_attrs %{comment: "some comment", definition: %{}, name: "some name", version: "some version"}
  @update_attrs %{comment: "some updated comment", definition: %{}, name: "some updated name", version: "some updated version"}
  @invalid_attrs %{comment: nil, definition: nil, name: nil, version: nil}

  describe "index" do
    test "lists all datadefs", %{conn: conn} do
      conn = get(conn, Routes.html_forms_datadef_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Datadefs"
    end
  end

  describe "new datadef" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_forms_datadef_path(conn, :new))
      assert html_response(conn, 200) =~ "New Datadef"
    end
  end

  describe "create datadef" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_forms_datadef_path(conn, :create), datadef: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_forms_datadef_path(conn, :show, id)

      conn = get(conn, Routes.html_forms_datadef_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Datadef"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_forms_datadef_path(conn, :create), datadef: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Datadef"
    end
  end

  describe "edit datadef" do
    setup [:create_datadef]

    test "renders form for editing chosen datadef", %{conn: conn, datadef: datadef} do
      conn = get(conn, Routes.html_forms_datadef_path(conn, :edit, datadef))
      assert html_response(conn, 200) =~ "Edit Datadef"
    end
  end

  describe "update datadef" do
    setup [:create_datadef]

    test "redirects when data is valid", %{conn: conn, datadef: datadef} do
      conn = put(conn, Routes.html_forms_datadef_path(conn, :update, datadef), datadef: @update_attrs)
      assert redirected_to(conn) == Routes.html_forms_datadef_path(conn, :show, datadef)

      conn = get(conn, Routes.html_forms_datadef_path(conn, :show, datadef))
      assert html_response(conn, 200) =~ "some updated comment"
    end

    test "renders errors when data is invalid", %{conn: conn, datadef: datadef} do
      conn = put(conn, Routes.html_forms_datadef_path(conn, :update, datadef), datadef: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Datadef"
    end
  end

  describe "delete datadef" do
    setup [:create_datadef]

    test "deletes chosen datadef", %{conn: conn, datadef: datadef} do
      conn = delete(conn, Routes.html_forms_datadef_path(conn, :delete, datadef))
      assert redirected_to(conn) == Routes.html_forms_datadef_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_forms_datadef_path(conn, :show, datadef))
      end
    end
  end

  defp create_datadef(_) do
    datadef = datadef_fixture()
    %{datadef: datadef}
  end
end
