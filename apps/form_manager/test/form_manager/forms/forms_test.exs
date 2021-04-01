defmodule FormManager.FormsTest do
  use FormManager.DataCase

  alias FormManager.Forms

  describe "forms" do
    alias FormManager.Forms.Form

    @valid_attrs %{author: "some author", definition: "some definition", name: "some name", version: "some version"}
    @update_attrs %{author: "some updated author", definition: "some updated definition", name: "some updated name", version: "some updated version"}
    @invalid_attrs %{author: nil, definition: nil, name: nil, version: nil}

    def form_fixture(attrs \\ %{}) do
      {:ok, form} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Forms.create_form()

      form
    end

    test "list_forms/0 returns all forms" do
      form = form_fixture()
      assert Forms.list_forms() == [form]
    end

    test "get_form!/1 returns the form with given id" do
      form = form_fixture()
      assert Forms.get_form!(form.id) == form
    end

    test "create_form/1 with valid data creates a form" do
      assert {:ok, %Form{} = form} = Forms.create_form(@valid_attrs)
      assert form.author == "some author"
      assert form.definition == "some definition"
      assert form.name == "some name"
      assert form.version == "some version"
    end

    test "create_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forms.create_form(@invalid_attrs)
    end

    test "update_form/2 with valid data updates the form" do
      form = form_fixture()
      assert {:ok, form} = Forms.update_form(form, @update_attrs)
      assert %Form{} = form
      assert form.author == "some updated author"
      assert form.definition == "some updated definition"
      assert form.name == "some updated name"
      assert form.version == "some updated version"
    end

    test "update_form/2 with invalid data returns error changeset" do
      form = form_fixture()
      assert {:error, %Ecto.Changeset{}} = Forms.update_form(form, @invalid_attrs)
      assert form == Forms.get_form!(form.id)
    end

    test "delete_form/1 deletes the form" do
      form = form_fixture()
      assert {:ok, %Form{}} = Forms.delete_form(form)
      assert_raise Ecto.NoResultsError, fn -> Forms.get_form!(form.id) end
    end

    test "change_form/1 returns a form changeset" do
      form = form_fixture()
      assert %Ecto.Changeset{} = Forms.change_form(form)
    end
  end

  describe "datasources" do
    alias FormManager.Forms.Datasource

    @valid_attrs %{actions: %{}, comment: "some comment", definition: %{}, name: "some name", version: "some version"}
    @update_attrs %{actions: %{}, comment: "some updated comment", definition: %{}, name: "some updated name", version: "some updated version"}
    @invalid_attrs %{actions: nil, comment: nil, definition: nil, name: nil, version: nil}

    def datasource_fixture(attrs \\ %{}) do
      {:ok, datasource} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Forms.create_datasource()

      datasource
    end

    test "list_datasources/0 returns all datasources" do
      datasource = datasource_fixture()
      assert Forms.list_datasources() == [datasource]
    end

    test "get_datasource!/1 returns the datasource with given id" do
      datasource = datasource_fixture()
      assert Forms.get_datasource!(datasource.id) == datasource
    end

    test "create_datasource/1 with valid data creates a datasource" do
      assert {:ok, %Datasource{} = datasource} = Forms.create_datasource(@valid_attrs)
      assert datasource.actions == %{}
      assert datasource.comment == "some comment"
      assert datasource.definition == %{}
      assert datasource.name == "some name"
      assert datasource.version == "some version"
    end

    test "create_datasource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forms.create_datasource(@invalid_attrs)
    end

    test "update_datasource/2 with valid data updates the datasource" do
      datasource = datasource_fixture()
      assert {:ok, datasource} = Forms.update_datasource(datasource, @update_attrs)
      assert %Datasource{} = datasource
      assert datasource.actions == %{}
      assert datasource.comment == "some updated comment"
      assert datasource.definition == %{}
      assert datasource.name == "some updated name"
      assert datasource.version == "some updated version"
    end

    test "update_datasource/2 with invalid data returns error changeset" do
      datasource = datasource_fixture()
      assert {:error, %Ecto.Changeset{}} = Forms.update_datasource(datasource, @invalid_attrs)
      assert datasource == Forms.get_datasource!(datasource.id)
    end

    test "delete_datasource/1 deletes the datasource" do
      datasource = datasource_fixture()
      assert {:ok, %Datasource{}} = Forms.delete_datasource(datasource)
      assert_raise Ecto.NoResultsError, fn -> Forms.get_datasource!(datasource.id) end
    end

    test "change_datasource/1 returns a datasource changeset" do
      datasource = datasource_fixture()
      assert %Ecto.Changeset{} = Forms.change_datasource(datasource)
    end
  end
end
