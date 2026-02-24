defmodule YicWeb.Api.Schemas.SchemaController do
  use YicWeb, :controller

  alias Yic.Schemas
  alias Yic.Schemas.Schema

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    schemas = Schemas.list_schemas()
    render(conn, "index.json", schemas: schemas)
  end

  def create(conn, %{"schema" => schema_params}) do
    with {:ok, %Schema{} = schema} <- Schemas.create_schema(schema_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_schemas_schema_path(conn, :show, schema))
      |> render("show.json", schema: schema)
    end
  end

  def show(conn, %{"id" => id}) do
    schema = Schemas.get_schema!(id)
    render(conn, "show.json", schema: schema)
  end

  def update(conn, %{"id" => id, "schema" => schema_params}) do
    schema = Schemas.get_schema!(id)

    with {:ok, %Schema{} = schema} <- Schemas.update_schema(schema, schema_params) do
      render(conn, "show.json", schema: schema)
    end
  end

  def delete(conn, %{"id" => id}) do
    schema = Schemas.get_schema!(id)

    with {:ok, %Schema{}} <- Schemas.delete_schema(schema) do
      send_resp(conn, :no_content, "")
    end
  end
end
