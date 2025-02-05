defmodule YicWeb.Flow.Tasks.TaskView do
  use YicWeb, :view
  alias YicWeb.Flow.Tasks.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{
      id: task.id,
      can_do: task.can_do
    }
  end
end
