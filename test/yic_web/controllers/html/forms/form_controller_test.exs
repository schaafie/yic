defmodule YicWeb.Html.Forms.FormControllerTest do
  use YicWeb.ConnCase

  import Yic.FormsFixtures

  @create_attrs %{comment: "some comment", definition: "some definition", name: "some name", version: "some version"}
  @update_attrs %{comment: "some updated comment", definition: "some updated definition", name: "some updated name", version: "some updated version"}
  @invalid_attrs %{comment: nil, definition: nil, name: nil, version: nil}

  describe "index" do
    test "lists all forms", %{conn: conn} do
      conn = get(conn, Routes.html_forms_form_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Forms"
    end
  end

  describe "new form" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_forms_form_path(conn, :new))
      assert html_response(conn, 200) =~ "New Form"
    end
  end

  describe "create form" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_forms_form_path(conn, :create), form: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_forms_form_path(conn, :show, id)

      conn = get(conn, Routes.html_forms_form_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Form"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_forms_form_path(conn, :create), form: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Form"
    end
  end

  describe "edit form" do
    setup [:create_form]

    test "renders form for editing chosen form", %{conn: conn, form: form} do
      conn = get(conn, Routes.html_forms_form_path(conn, :edit, form))
      assert html_response(conn, 200) =~ "Edit Form"
    end
  end

  describe "update form" do
    setup [:create_form]

    test "redirects when data is valid", %{conn: conn, form: form} do
      conn = put(conn, Routes.html_forms_form_path(conn, :update, form), form: @update_attrs)
      assert redirected_to(conn) == Routes.html_forms_form_path(conn, :show, form)

      conn = get(conn, Routes.html_forms_form_path(conn, :show, form))
      assert html_response(conn, 200) =~ "some updated comment"
    end

    test "renders errors when data is invalid", %{conn: conn, form: form} do
      conn = put(conn, Routes.html_forms_form_path(conn, :update, form), form: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Form"
    end
  end

  describe "delete form" do
    setup [:create_form]

    test "deletes chosen form", %{conn: conn, form: form} do
      conn = delete(conn, Routes.html_forms_form_path(conn, :delete, form))
      assert redirected_to(conn) == Routes.html_forms_form_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_forms_form_path(conn, :show, form))
      end
    end
  end

  defp create_form(_) do
    form = form_fixture()
    %{form: form}
  end
end
