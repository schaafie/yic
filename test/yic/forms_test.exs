defmodule Yic.FormsTest do
  use Yic.DataCase

  alias Yic.Forms

  describe "forms" do
    alias Yic.Forms.Form

    import Yic.FormsFixtures

    @invalid_attrs %{comment: nil, definition: nil, name: nil, version: nil}

    test "list_forms/0 returns all forms" do
      form = form_fixture()
      assert Forms.list_forms() == [form]
    end

    test "get_form!/1 returns the form with given id" do
      form = form_fixture()
      assert Forms.get_form!(form.id) == form
    end

    test "create_form/1 with valid data creates a form" do
      valid_attrs = %{comment: "some comment", definition: "some definition", name: "some name", version: "some version"}

      assert {:ok, %Form{} = form} = Forms.create_form(valid_attrs)
      assert form.comment == "some comment"
      assert form.definition == "some definition"
      assert form.name == "some name"
      assert form.version == "some version"
    end

    test "create_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forms.create_form(@invalid_attrs)
    end

    test "update_form/2 with valid data updates the form" do
      form = form_fixture()
      update_attrs = %{comment: "some updated comment", definition: "some updated definition", name: "some updated name", version: "some updated version"}

      assert {:ok, %Form{} = form} = Forms.update_form(form, update_attrs)
      assert form.comment == "some updated comment"
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
    alias Yic.Forms.Datasource

    import Yic.FormsFixtures

    @invalid_attrs %{actions: nil, comment: nil, definition: nil, name: nil, version: nil}

    test "list_datasources/0 returns all datasources" do
      datasource = datasource_fixture()
      assert Forms.list_datasources() == [datasource]
    end

    test "get_datasource!/1 returns the datasource with given id" do
      datasource = datasource_fixture()
      assert Forms.get_datasource!(datasource.id) == datasource
    end

    test "create_datasource/1 with valid data creates a datasource" do
      valid_attrs = %{actions: [], comment: "some comment", definition: "some definition", name: "some name", version: "some version"}

      assert {:ok, %Datasource{} = datasource} = Forms.create_datasource(valid_attrs)
      assert datasource.actions == []
      assert datasource.comment == "some comment"
      assert datasource.definition == "some definition"
      assert datasource.name == "some name"
      assert datasource.version == "some version"
    end

    test "create_datasource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forms.create_datasource(@invalid_attrs)
    end

    test "update_datasource/2 with valid data updates the datasource" do
      datasource = datasource_fixture()
      update_attrs = %{actions: [], comment: "some updated comment", definition: "some updated definition", name: "some updated name", version: "some updated version"}

      assert {:ok, %Datasource{} = datasource} = Forms.update_datasource(datasource, update_attrs)
      assert datasource.actions == []
      assert datasource.comment == "some updated comment"
      assert datasource.definition == "some updated definition"
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
