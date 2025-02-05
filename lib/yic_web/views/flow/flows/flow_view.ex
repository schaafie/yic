defmodule YicWeb.Flow.Flows.FlowView do
  use YicWeb, :view
  alias YicWeb.Flow.Flows.FlowView

  def render("index.json", %{flows: flows}) do
    %{data: render_many(flows, FlowView, "flow.json")}
  end

  def render("show.json", %{flow: flow}) do
    %{data: render_one(flow, FlowView, "flow.json")}
  end

  def render("flow.json", %{flow: flow}) do
    %{
      id: flow.id,
      name: flow.name,
      description: flow.description,
      version: flow.version,
      definition: flow.definition,
      can_start: flow.can_start
    }
  end
end
