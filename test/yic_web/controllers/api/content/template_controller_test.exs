defmodule YicWeb.Api.Content.TemplateControllerTest do
  use YicWeb.ConnCase

  import Yic.ContentFixtures

  alias Yic.Content.Template

  @create_attrs %{
    definition: %{},
    description: "some description",
    name: "some name",
    version: %{}
  }
  @update_attrs %{
    definition: %{},
    description: "some updated description",
    name: "some updated name",
    version: %{}
  }
  @invalid_attrs %{definition: nil, description: nil, name: nil, version: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all templates", %{conn: conn} do
      conn = get(conn, Routes.api_content_template_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create template" do
    test "renders template when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_content_template_path(conn, :create), template: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_content_template_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "definition" => %{},
               "description" => "some description",
               "name" => "some name",
               "version" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_content_template_path(conn, :create), template: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update template" do
    setup [:create_template]

    test "renders template when data is valid", %{conn: conn, template: %Template{id: id} = template} do
      conn = put(conn, Routes.api_content_template_path(conn, :update, template), template: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_content_template_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "definition" => %{},
               "description" => "some updated description",
               "name" => "some updated name",
               "version" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, template: template} do
      conn = put(conn, Routes.api_content_template_path(conn, :update, template), template: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete template" do
    setup [:create_template]

    test "deletes chosen template", %{conn: conn, template: template} do
      conn = delete(conn, Routes.api_content_template_path(conn, :delete, template))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_content_template_path(conn, :show, template))
      end
    end
  end

  defp create_template(_) do
    template = template_fixture()
    %{template: template}
  end
end
