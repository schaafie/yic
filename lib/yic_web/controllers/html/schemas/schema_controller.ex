defmodule YicWeb.Html.Schemas.SchemaController do
  use YicWeb, :controller

  alias Yic.Schemas
  alias Yic.Schemas.Schema

  def index(conn, _params) do
    schemas = Schemas.list_schemas()
    render(conn, "index.html", schemas: schemas)
  end

  def new(conn, _params) do
    changeset = Schemas.change_schema(%Schema{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"schema" => schema_params}) do
    case Schemas.create_schema(schema_params) do
      {:ok, schema} ->
        conn
        |> put_flash(:info, "Schema created successfully.")
        |> redirect(to: Routes.html_schemas_schema_path(conn, :show, schema))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    schema = Schemas.get_schema!(id)
    render(conn, "show.html", schema: schema)
  end

  def edit(conn, %{"id" => id}) do
    schema = Schemas.get_schema!(id)
    changeset = Schemas.change_schema(schema)
    render(conn, "edit.html", schema: schema, changeset: changeset)
  end

  def update(conn, %{"id" => id, "schema" => schema_params}) do
    schema = Schemas.get_schema!(id)

    case Schemas.update_schema(schema, schema_params) do
      {:ok, schema} ->
        conn
        |> put_flash(:info, "Schema updated successfully.")
        |> redirect(to: Routes.html_schemas_schema_path(conn, :show, schema))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", schema: schema, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    schema = Schemas.get_schema!(id)
    {:ok, _schema} = Schemas.delete_schema(schema)

    conn
    |> put_flash(:info, "Schema deleted successfully.")
    |> redirect(to: Routes.html_schemas_schema_path(conn, :index))
  end
end
