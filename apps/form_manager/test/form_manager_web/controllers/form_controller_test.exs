defmodule FormManagerWeb.FormControllerTest do
  use FormManagerWeb.ConnCase

  alias FormManager.Forms
  alias FormManager.Forms.Form

  @create_attrs %{author: "some author", definition: "some definition", name: "some name", version: "some version"}
  @update_attrs %{author: "some updated author", definition: "some updated definition", name: "some updated name", version: "some updated version"}
  @invalid_attrs %{author: nil, definition: nil, name: nil, version: nil}

  def fixture(:form) do
    {:ok, form} = Forms.create_form(@create_attrs)
    form
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all forms", %{conn: conn} do
      conn = get conn, form_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create form" do
    test "renders form when data is valid", %{conn: conn} do
      conn = post conn, form_path(conn, :create), form: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, form_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "author" => "some author",
        "definition" => "some definition",
        "name" => "some name",
        "version" => "some version"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, form_path(conn, :create), form: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update form" do
    setup [:create_form]

    test "renders form when data is valid", %{conn: conn, form: %Form{id: id} = form} do
      conn = put conn, form_path(conn, :update, form), form: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, form_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "author" => "some updated author",
        "definition" => "some updated definition",
        "name" => "some updated name",
        "version" => "some updated version"}
    end

    test "renders errors when data is invalid", %{conn: conn, form: form} do
      conn = put conn, form_path(conn, :update, form), form: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete form" do
    setup [:create_form]

    test "deletes chosen form", %{conn: conn, form: form} do
      conn = delete conn, form_path(conn, :delete, form)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, form_path(conn, :show, form)
      end
    end
  end

  defp create_form(_) do
    form = fixture(:form)
    {:ok, form: form}
  end
end
