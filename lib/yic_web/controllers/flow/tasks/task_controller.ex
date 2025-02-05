defmodule YicWeb.Flow.Tasks.TaskController do
  use YicWeb, :controller

  alias Yic.Flows
  alias Yic.Flows.Task

  action_fallback YicWeb.FallbackController

  def index(conn, _params) do
    tasks = Flows.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Flows.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.flow_tasks_task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Flows.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Flows.get_task!(id)

    with {:ok, %Task{} = task} <- Flows.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Flows.get_task!(id)

    with {:ok, %Task{}} <- Flows.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
