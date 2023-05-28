defmodule YicWeb.Api.Content.ItemControllerTest do
  use YicWeb.ConnCase

  import Yic.ContentFixtures

  alias Yic.Content.Item

  @create_attrs %{
    content: %{},
    description: "some description",
    name: "some name",
    version: %{}
  }
  @update_attrs %{
    content: %{},
    description: "some updated description",
    name: "some updated name",
    version: %{}
  }
  @invalid_attrs %{content: nil, description: nil, name: nil, version: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.api_content_item_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create item" do
    test "renders item when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_content_item_path(conn, :create), item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_content_item_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "content" => %{},
               "description" => "some description",
               "name" => "some name",
               "version" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_content_item_path(conn, :create), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update item" do
    setup [:create_item]

    test "renders item when data is valid", %{conn: conn, item: %Item{id: id} = item} do
      conn = put(conn, Routes.api_content_item_path(conn, :update, item), item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_content_item_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "content" => %{},
               "description" => "some updated description",
               "name" => "some updated name",
               "version" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, item: item} do
      conn = put(conn, Routes.api_content_item_path(conn, :update, item), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete(conn, Routes.api_content_item_path(conn, :delete, item))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_content_item_path(conn, :show, item))
      end
    end
  end

  defp create_item(_) do
    item = item_fixture()
    %{item: item}
  end
end
