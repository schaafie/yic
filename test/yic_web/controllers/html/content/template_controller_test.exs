defmodule YicWeb.Html.Content.TemplateControllerTest do
  use YicWeb.ConnCase

  import Yic.ContentFixtures

  @create_attrs %{definition: %{}, description: "some description", name: "some name", version: %{}}
  @update_attrs %{definition: %{}, description: "some updated description", name: "some updated name", version: %{}}
  @invalid_attrs %{definition: nil, description: nil, name: nil, version: nil}

  describe "index" do
    test "lists all templates", %{conn: conn} do
      conn = get(conn, Routes.html_content_template_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Templates"
    end
  end

  describe "new template" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_content_template_path(conn, :new))
      assert html_response(conn, 200) =~ "New Template"
    end
  end

  describe "create template" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_content_template_path(conn, :create), template: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_content_template_path(conn, :show, id)

      conn = get(conn, Routes.html_content_template_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Template"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_content_template_path(conn, :create), template: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Template"
    end
  end

  describe "edit template" do
    setup [:create_template]

    test "renders form for editing chosen template", %{conn: conn, template: template} do
      conn = get(conn, Routes.html_content_template_path(conn, :edit, template))
      assert html_response(conn, 200) =~ "Edit Template"
    end
  end

  describe "update template" do
    setup [:create_template]

    test "redirects when data is valid", %{conn: conn, template: template} do
      conn = put(conn, Routes.html_content_template_path(conn, :update, template), template: @update_attrs)
      assert redirected_to(conn) == Routes.html_content_template_path(conn, :show, template)

      conn = get(conn, Routes.html_content_template_path(conn, :show, template))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, template: template} do
      conn = put(conn, Routes.html_content_template_path(conn, :update, template), template: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Template"
    end
  end

  describe "delete template" do
    setup [:create_template]

    test "deletes chosen template", %{conn: conn, template: template} do
      conn = delete(conn, Routes.html_content_template_path(conn, :delete, template))
      assert redirected_to(conn) == Routes.html_content_template_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_content_template_path(conn, :show, template))
      end
    end
  end

  defp create_template(_) do
    template = template_fixture()
    %{template: template}
  end
end
