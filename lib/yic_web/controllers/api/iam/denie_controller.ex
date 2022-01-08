defmodule YicWeb.Api.Iam.DenieController do
  use YicWeb, :controller

  alias Yic.Iam
  alias Yic.Iam.Denie

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    denies = Iam.list_denies()
    render(conn, "index.json", denies: denies)
  end

  def create(conn, %{"denie" => denie_params}) do
    with {:ok, %Denie{} = denie} <- Iam.create_denie(denie_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_iam_denie_path(conn, :show, denie))
      |> render("show.json", denie: denie)
    end
  end

  def show(conn, %{"id" => id}) do
    denie = Iam.get_denie!(id)
    render(conn, "show.json", denie: denie)
  end

  def update(conn, %{"id" => id, "denie" => denie_params}) do
    denie = Iam.get_denie!(id)

    with {:ok, %Denie{} = denie} <- Iam.update_denie(denie, denie_params) do
      render(conn, "show.json", denie: denie)
    end
  end

  def delete(conn, %{"id" => id}) do
    denie = Iam.get_denie!(id)

    with {:ok, %Denie{}} <- Iam.delete_denie(denie) do
      send_resp(conn, :no_content, "")
    end
  end
end
