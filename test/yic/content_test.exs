defmodule Yic.ContentTest do
  use Yic.DataCase

  alias Yic.Content

  describe "templates" do
    alias Yic.Content.Template

    import Yic.ContentFixtures

    @invalid_attrs %{definition: nil, description: nil, name: nil, version: nil}

    test "list_templates/0 returns all templates" do
      template = template_fixture()
      assert Content.list_templates() == [template]
    end

    test "get_template!/1 returns the template with given id" do
      template = template_fixture()
      assert Content.get_template!(template.id) == template
    end

    test "create_template/1 with valid data creates a template" do
      valid_attrs = %{definition: %{}, description: "some description", name: "some name", version: %{}}

      assert {:ok, %Template{} = template} = Content.create_template(valid_attrs)
      assert template.definition == %{}
      assert template.description == "some description"
      assert template.name == "some name"
      assert template.version == %{}
    end

    test "create_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_template(@invalid_attrs)
    end

    test "update_template/2 with valid data updates the template" do
      template = template_fixture()
      update_attrs = %{definition: %{}, description: "some updated description", name: "some updated name", version: %{}}

      assert {:ok, %Template{} = template} = Content.update_template(template, update_attrs)
      assert template.definition == %{}
      assert template.description == "some updated description"
      assert template.name == "some updated name"
      assert template.version == %{}
    end

    test "update_template/2 with invalid data returns error changeset" do
      template = template_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_template(template, @invalid_attrs)
      assert template == Content.get_template!(template.id)
    end

    test "delete_template/1 deletes the template" do
      template = template_fixture()
      assert {:ok, %Template{}} = Content.delete_template(template)
      assert_raise Ecto.NoResultsError, fn -> Content.get_template!(template.id) end
    end

    test "change_template/1 returns a template changeset" do
      template = template_fixture()
      assert %Ecto.Changeset{} = Content.change_template(template)
    end
  end

  describe "items" do
    alias Yic.Content.Item

    import Yic.ContentFixtures

    @invalid_attrs %{content: nil, description: nil, name: nil, version: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Content.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Content.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{content: %{}, description: "some description", name: "some name", version: %{}}

      assert {:ok, %Item{} = item} = Content.create_item(valid_attrs)
      assert item.content == %{}
      assert item.description == "some description"
      assert item.name == "some name"
      assert item.version == %{}
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{content: %{}, description: "some updated description", name: "some updated name", version: %{}}

      assert {:ok, %Item{} = item} = Content.update_item(item, update_attrs)
      assert item.content == %{}
      assert item.description == "some updated description"
      assert item.name == "some updated name"
      assert item.version == %{}
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_item(item, @invalid_attrs)
      assert item == Content.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Content.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Content.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Content.change_item(item)
    end
  end
end
