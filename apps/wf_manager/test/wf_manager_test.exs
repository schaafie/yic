defmodule WfManagerTest do
  use ExUnit.Case
  doctest WfManager

  test "greets the world" do
    assert WfManager.hello() == :world
  end
end
