defmodule PublicationManager.PublicationsTest do
  use PublicationManager.DataCase

  alias PublicationManager.Publications

  describe "publications" do
    alias PublicationManager.Publications.Publication

    @valid_attrs %{definition: "some definition", end: "2010-04-17 14:00:00.000000Z", path: "some path", start: "2010-04-17 14:00:00.000000Z", target: 42, version: "some version"}
    @update_attrs %{definition: "some updated definition", end: "2011-05-18 15:01:01.000000Z", path: "some updated path", start: "2011-05-18 15:01:01.000000Z", target: 43, version: "some updated version"}
    @invalid_attrs %{definition: nil, end: nil, path: nil, start: nil, target: nil, version: nil}

    def publication_fixture(attrs \\ %{}) do
      {:ok, publication} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Publications.create_publication()

      publication
    end

    test "list_publications/0 returns all publications" do
      publication = publication_fixture()
      assert Publications.list_publications() == [publication]
    end

    test "get_publication!/1 returns the publication with given id" do
      publication = publication_fixture()
      assert Publications.get_publication!(publication.id) == publication
    end

    test "create_publication/1 with valid data creates a publication" do
      assert {:ok, %Publication{} = publication} = Publications.create_publication(@valid_attrs)
      assert publication.definition == "some definition"
      assert publication.end == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert publication.path == "some path"
      assert publication.start == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert publication.target == 42
      assert publication.version == "some version"
    end

    test "create_publication/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Publications.create_publication(@invalid_attrs)
    end

    test "update_publication/2 with valid data updates the publication" do
      publication = publication_fixture()
      assert {:ok, publication} = Publications.update_publication(publication, @update_attrs)
      assert %Publication{} = publication
      assert publication.definition == "some updated definition"
      assert publication.end == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert publication.path == "some updated path"
      assert publication.start == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert publication.target == 43
      assert publication.version == "some updated version"
    end

    test "update_publication/2 with invalid data returns error changeset" do
      publication = publication_fixture()
      assert {:error, %Ecto.Changeset{}} = Publications.update_publication(publication, @invalid_attrs)
      assert publication == Publications.get_publication!(publication.id)
    end

    test "delete_publication/1 deletes the publication" do
      publication = publication_fixture()
      assert {:ok, %Publication{}} = Publications.delete_publication(publication)
      assert_raise Ecto.NoResultsError, fn -> Publications.get_publication!(publication.id) end
    end

    test "change_publication/1 returns a publication changeset" do
      publication = publication_fixture()
      assert %Ecto.Changeset{} = Publications.change_publication(publication)
    end
  end
end
