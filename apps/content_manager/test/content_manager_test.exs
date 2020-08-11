defmodule ContentManagerTest do
  use ExUnit.Case
  doctest ContentManager

  test "greets the world" do
    assert ContentManager.hello() == :world
  end
end
