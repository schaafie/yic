defmodule ApiManagerTest do
  use ExUnit.Case
  doctest ApiManager

  test "greets the world" do
    assert ApiManager.hello() == :world
  end
end
