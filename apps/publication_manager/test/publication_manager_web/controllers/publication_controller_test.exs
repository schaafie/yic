defmodule PublicationManagerWeb.PublicationControllerTest do
  use PublicationManagerWeb.ConnCase

  alias PublicationManager.Publications
  alias PublicationManager.Publications.Publication

  @create_attrs %{definition: "some definition", end: "2010-04-17 14:00:00.000000Z", path: "some path", start: "2010-04-17 14:00:00.000000Z", target: 42, version: "some version"}
  @update_attrs %{definition: "some updated definition", end: "2011-05-18 15:01:01.000000Z", path: "some updated path", start: "2011-05-18 15:01:01.000000Z", target: 43, version: "some updated version"}
  @invalid_attrs %{definition: nil, end: nil, path: nil, start: nil, target: nil, version: nil}

  def fixture(:publication) do
    {:ok, publication} = Publications.create_publication(@create_attrs)
    publication
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all publications", %{conn: conn} do
      conn = get conn, publication_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create publication" do
    test "renders publication when data is valid", %{conn: conn} do
      conn = post conn, publication_path(conn, :create), publication: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, publication_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "definition" => "some definition",
        "end" => "2010-04-17 14:00:00.000000Z",
        "path" => "some path",
        "start" => "2010-04-17 14:00:00.000000Z",
        "target" => 42,
        "version" => "some version"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, publication_path(conn, :create), publication: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update publication" do
    setup [:create_publication]

    test "renders publication when data is valid", %{conn: conn, publication: %Publication{id: id} = publication} do
      conn = put conn, publication_path(conn, :update, publication), publication: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, publication_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "definition" => "some updated definition",
        "end" => "2011-05-18 15:01:01.000000Z",
        "path" => "some updated path",
        "start" => "2011-05-18 15:01:01.000000Z",
        "target" => 43,
        "version" => "some updated version"}
    end

    test "renders errors when data is invalid", %{conn: conn, publication: publication} do
      conn = put conn, publication_path(conn, :update, publication), publication: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete publication" do
    setup [:create_publication]

    test "deletes chosen publication", %{conn: conn, publication: publication} do
      conn = delete conn, publication_path(conn, :delete, publication)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, publication_path(conn, :show, publication)
      end
    end
  end

  defp create_publication(_) do
    publication = fixture(:publication)
    {:ok, publication: publication}
  end
end
