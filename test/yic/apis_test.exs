defmodule Yic.ApisTest do
  use Yic.DataCase

  alias Yic.Apis

  describe "apis" do
    alias Yic.Apis.Api

    import Yic.ApisFixtures

    @invalid_attrs %{definition: nil, description: nil, name: nil, request: nil, version: nil}

    test "list_apis/0 returns all apis" do
      api = api_fixture()
      assert Apis.list_apis() == [api]
    end

    test "get_api!/1 returns the api with given id" do
      api = api_fixture()
      assert Apis.get_api!(api.id) == api
    end

    test "create_api/1 with valid data creates a api" do
      valid_attrs = %{definition: "some definition", description: "some description", name: "some name", request: "some request", version: "some version"}

      assert {:ok, %Api{} = api} = Apis.create_api(valid_attrs)
      assert api.definition == "some definition"
      assert api.description == "some description"
      assert api.name == "some name"
      assert api.request == "some request"
      assert api.version == "some version"
    end

    test "create_api/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apis.create_api(@invalid_attrs)
    end

    test "update_api/2 with valid data updates the api" do
      api = api_fixture()
      update_attrs = %{definition: "some updated definition", description: "some updated description", name: "some updated name", request: "some updated request", version: "some updated version"}

      assert {:ok, %Api{} = api} = Apis.update_api(api, update_attrs)
      assert api.definition == "some updated definition"
      assert api.description == "some updated description"
      assert api.name == "some updated name"
      assert api.request == "some updated request"
      assert api.version == "some updated version"
    end

    test "update_api/2 with invalid data returns error changeset" do
      api = api_fixture()
      assert {:error, %Ecto.Changeset{}} = Apis.update_api(api, @invalid_attrs)
      assert api == Apis.get_api!(api.id)
    end

    test "delete_api/1 deletes the api" do
      api = api_fixture()
      assert {:ok, %Api{}} = Apis.delete_api(api)
      assert_raise Ecto.NoResultsError, fn -> Apis.get_api!(api.id) end
    end

    test "change_api/1 returns a api changeset" do
      api = api_fixture()
      assert %Ecto.Changeset{} = Apis.change_api(api)
    end
  end
end
