defmodule YicWeb.Html.Forms.DatasourceControllerTest do
  use YicWeb.ConnCase

  import Yic.FormsFixtures

  @create_attrs %{actions: [], comment: "some comment", definition: "some definition", name: "some name", version: "some version"}
  @update_attrs %{actions: [], comment: "some updated comment", definition: "some updated definition", name: "some updated name", version: "some updated version"}
  @invalid_attrs %{actions: nil, comment: nil, definition: nil, name: nil, version: nil}

  describe "index" do
    test "lists all datasources", %{conn: conn} do
      conn = get(conn, Routes.html_forms_datasource_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Datasources"
    end
  end

  describe "new datasource" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_forms_datasource_path(conn, :new))
      assert html_response(conn, 200) =~ "New Datasource"
    end
  end

  describe "create datasource" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_forms_datasource_path(conn, :create), datasource: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_forms_datasource_path(conn, :show, id)

      conn = get(conn, Routes.html_forms_datasource_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Datasource"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_forms_datasource_path(conn, :create), datasource: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Datasource"
    end
  end

  describe "edit datasource" do
    setup [:create_datasource]

    test "renders form for editing chosen datasource", %{conn: conn, datasource: datasource} do
      conn = get(conn, Routes.html_forms_datasource_path(conn, :edit, datasource))
      assert html_response(conn, 200) =~ "Edit Datasource"
    end
  end

  describe "update datasource" do
    setup [:create_datasource]

    test "redirects when data is valid", %{conn: conn, datasource: datasource} do
      conn = put(conn, Routes.html_forms_datasource_path(conn, :update, datasource), datasource: @update_attrs)
      assert redirected_to(conn) == Routes.html_forms_datasource_path(conn, :show, datasource)

      conn = get(conn, Routes.html_forms_datasource_path(conn, :show, datasource))
      assert html_response(conn, 200) =~ "some updated comment"
    end

    test "renders errors when data is invalid", %{conn: conn, datasource: datasource} do
      conn = put(conn, Routes.html_forms_datasource_path(conn, :update, datasource), datasource: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Datasource"
    end
  end

  describe "delete datasource" do
    setup [:create_datasource]

    test "deletes chosen datasource", %{conn: conn, datasource: datasource} do
      conn = delete(conn, Routes.html_forms_datasource_path(conn, :delete, datasource))
      assert redirected_to(conn) == Routes.html_forms_datasource_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_forms_datasource_path(conn, :show, datasource))
      end
    end
  end

  defp create_datasource(_) do
    datasource = datasource_fixture()
    %{datasource: datasource}
  end
end
