defmodule YicWeb.Html.Content.ItemControllerTest do
  use YicWeb.ConnCase

  import Yic.ContentFixtures

  @create_attrs %{content: %{}, description: "some description", name: "some name", version: %{}}
  @update_attrs %{content: %{}, description: "some updated description", name: "some updated name", version: %{}}
  @invalid_attrs %{content: nil, description: nil, name: nil, version: nil}

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.html_content_item_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Items"
    end
  end

  describe "new item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_content_item_path(conn, :new))
      assert html_response(conn, 200) =~ "New Item"
    end
  end

  describe "create item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_content_item_path(conn, :create), item: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_content_item_path(conn, :show, id)

      conn = get(conn, Routes.html_content_item_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Item"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_content_item_path(conn, :create), item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Item"
    end
  end

  describe "edit item" do
    setup [:create_item]

    test "renders form for editing chosen item", %{conn: conn, item: item} do
      conn = get(conn, Routes.html_content_item_path(conn, :edit, item))
      assert html_response(conn, 200) =~ "Edit Item"
    end
  end

  describe "update item" do
    setup [:create_item]

    test "redirects when data is valid", %{conn: conn, item: item} do
      conn = put(conn, Routes.html_content_item_path(conn, :update, item), item: @update_attrs)
      assert redirected_to(conn) == Routes.html_content_item_path(conn, :show, item)

      conn = get(conn, Routes.html_content_item_path(conn, :show, item))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, item: item} do
      conn = put(conn, Routes.html_content_item_path(conn, :update, item), item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Item"
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete(conn, Routes.html_content_item_path(conn, :delete, item))
      assert redirected_to(conn) == Routes.html_content_item_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_content_item_path(conn, :show, item))
      end
    end
  end

  defp create_item(_) do
    item = item_fixture()
    %{item: item}
  end
end
