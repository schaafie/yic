defmodule Yic.FlowsTest do
  use Yic.DataCase

  alias Yic.Flows

  describe "flows" do
    alias Yic.Flows.Flow

    import Yic.FlowsFixtures

    @invalid_attrs %{can_start: nil, definition: nil, description: nil, name: nil, version: nil}

    test "list_flows/0 returns all flows" do
      flow = flow_fixture()
      assert Flows.list_flows() == [flow]
    end

    test "get_flow!/1 returns the flow with given id" do
      flow = flow_fixture()
      assert Flows.get_flow!(flow.id) == flow
    end

    test "create_flow/1 with valid data creates a flow" do
      valid_attrs = %{can_start: %{}, definition: %{}, description: "some description", name: "some name", version: %{}}

      assert {:ok, %Flow{} = flow} = Flows.create_flow(valid_attrs)
      assert flow.can_start == %{}
      assert flow.definition == %{}
      assert flow.description == "some description"
      assert flow.name == "some name"
      assert flow.version == %{}
    end

    test "create_flow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flows.create_flow(@invalid_attrs)
    end

    test "update_flow/2 with valid data updates the flow" do
      flow = flow_fixture()
      update_attrs = %{can_start: %{}, definition: %{}, description: "some updated description", name: "some updated name", version: %{}}

      assert {:ok, %Flow{} = flow} = Flows.update_flow(flow, update_attrs)
      assert flow.can_start == %{}
      assert flow.definition == %{}
      assert flow.description == "some updated description"
      assert flow.name == "some updated name"
      assert flow.version == %{}
    end

    test "update_flow/2 with invalid data returns error changeset" do
      flow = flow_fixture()
      assert {:error, %Ecto.Changeset{}} = Flows.update_flow(flow, @invalid_attrs)
      assert flow == Flows.get_flow!(flow.id)
    end

    test "delete_flow/1 deletes the flow" do
      flow = flow_fixture()
      assert {:ok, %Flow{}} = Flows.delete_flow(flow)
      assert_raise Ecto.NoResultsError, fn -> Flows.get_flow!(flow.id) end
    end

    test "change_flow/1 returns a flow changeset" do
      flow = flow_fixture()
      assert %Ecto.Changeset{} = Flows.change_flow(flow)
    end
  end

  describe "tokens" do
    alias Yic.Flows.Token

    import Yic.FlowsFixtures

    @invalid_attrs %{can_do: nil, current_task: nil}

    test "list_tokens/0 returns all tokens" do
      token = token_fixture()
      assert Flows.list_tokens() == [token]
    end

    test "get_token!/1 returns the token with given id" do
      token = token_fixture()
      assert Flows.get_token!(token.id) == token
    end

    test "create_token/1 with valid data creates a token" do
      valid_attrs = %{can_do: %{}, current_task: "some current_task"}

      assert {:ok, %Token{} = token} = Flows.create_token(valid_attrs)
      assert token.can_do == %{}
      assert token.current_task == "some current_task"
    end

    test "create_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flows.create_token(@invalid_attrs)
    end

    test "update_token/2 with valid data updates the token" do
      token = token_fixture()
      update_attrs = %{can_do: %{}, current_task: "some updated current_task"}

      assert {:ok, %Token{} = token} = Flows.update_token(token, update_attrs)
      assert token.can_do == %{}
      assert token.current_task == "some updated current_task"
    end

    test "update_token/2 with invalid data returns error changeset" do
      token = token_fixture()
      assert {:error, %Ecto.Changeset{}} = Flows.update_token(token, @invalid_attrs)
      assert token == Flows.get_token!(token.id)
    end

    test "delete_token/1 deletes the token" do
      token = token_fixture()
      assert {:ok, %Token{}} = Flows.delete_token(token)
      assert_raise Ecto.NoResultsError, fn -> Flows.get_token!(token.id) end
    end

    test "change_token/1 returns a token changeset" do
      token = token_fixture()
      assert %Ecto.Changeset{} = Flows.change_token(token)
    end
  end
end
