defmodule YicWeb.Html.Apis.ApiControllerTest do
  use YicWeb.ConnCase

  import Yic.ApisFixtures

  @create_attrs %{definition: "some definition", description: "some description", name: "some name", request: "some request", version: "some version"}
  @update_attrs %{definition: "some updated definition", description: "some updated description", name: "some updated name", request: "some updated request", version: "some updated version"}
  @invalid_attrs %{definition: nil, description: nil, name: nil, request: nil, version: nil}

  describe "index" do
    test "lists all apis", %{conn: conn} do
      conn = get(conn, Routes.html_apis_api_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Apis"
    end
  end

  describe "new api" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_apis_api_path(conn, :new))
      assert html_response(conn, 200) =~ "New Api"
    end
  end

  describe "create api" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_apis_api_path(conn, :create), api: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_apis_api_path(conn, :show, id)

      conn = get(conn, Routes.html_apis_api_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Api"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_apis_api_path(conn, :create), api: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Api"
    end
  end

  describe "edit api" do
    setup [:create_api]

    test "renders form for editing chosen api", %{conn: conn, api: api} do
      conn = get(conn, Routes.html_apis_api_path(conn, :edit, api))
      assert html_response(conn, 200) =~ "Edit Api"
    end
  end

  describe "update api" do
    setup [:create_api]

    test "redirects when data is valid", %{conn: conn, api: api} do
      conn = put(conn, Routes.html_apis_api_path(conn, :update, api), api: @update_attrs)
      assert redirected_to(conn) == Routes.html_apis_api_path(conn, :show, api)

      conn = get(conn, Routes.html_apis_api_path(conn, :show, api))
      assert html_response(conn, 200) =~ "some updated definition"
    end

    test "renders errors when data is invalid", %{conn: conn, api: api} do
      conn = put(conn, Routes.html_apis_api_path(conn, :update, api), api: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Api"
    end
  end

  describe "delete api" do
    setup [:create_api]

    test "deletes chosen api", %{conn: conn, api: api} do
      conn = delete(conn, Routes.html_apis_api_path(conn, :delete, api))
      assert redirected_to(conn) == Routes.html_apis_api_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_apis_api_path(conn, :show, api))
      end
    end
  end

  defp create_api(_) do
    api = api_fixture()
    %{api: api}
  end
end
