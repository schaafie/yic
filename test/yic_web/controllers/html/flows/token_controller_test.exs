defmodule YicWeb.Html.Flows.TokenControllerTest do
  use YicWeb.ConnCase

  import Yic.FlowsFixtures

  @create_attrs %{can_do: %{}, current_task: "some current_task"}
  @update_attrs %{can_do: %{}, current_task: "some updated current_task"}
  @invalid_attrs %{can_do: nil, current_task: nil}

  describe "index" do
    test "lists all tokens", %{conn: conn} do
      conn = get(conn, Routes.html_flows_token_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tokens"
    end
  end

  describe "new token" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.html_flows_token_path(conn, :new))
      assert html_response(conn, 200) =~ "New Token"
    end
  end

  describe "create token" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.html_flows_token_path(conn, :create), token: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.html_flows_token_path(conn, :show, id)

      conn = get(conn, Routes.html_flows_token_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Token"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.html_flows_token_path(conn, :create), token: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Token"
    end
  end

  describe "edit token" do
    setup [:create_token]

    test "renders form for editing chosen token", %{conn: conn, token: token} do
      conn = get(conn, Routes.html_flows_token_path(conn, :edit, token))
      assert html_response(conn, 200) =~ "Edit Token"
    end
  end

  describe "update token" do
    setup [:create_token]

    test "redirects when data is valid", %{conn: conn, token: token} do
      conn = put(conn, Routes.html_flows_token_path(conn, :update, token), token: @update_attrs)
      assert redirected_to(conn) == Routes.html_flows_token_path(conn, :show, token)

      conn = get(conn, Routes.html_flows_token_path(conn, :show, token))
      assert html_response(conn, 200) =~ "some updated current_task"
    end

    test "renders errors when data is invalid", %{conn: conn, token: token} do
      conn = put(conn, Routes.html_flows_token_path(conn, :update, token), token: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Token"
    end
  end

  describe "delete token" do
    setup [:create_token]

    test "deletes chosen token", %{conn: conn, token: token} do
      conn = delete(conn, Routes.html_flows_token_path(conn, :delete, token))
      assert redirected_to(conn) == Routes.html_flows_token_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.html_flows_token_path(conn, :show, token))
      end
    end
  end

  defp create_token(_) do
    token = token_fixture()
    %{token: token}
  end
end
