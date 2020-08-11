defmodule UserManagerTest do
  use ExUnit.Case
  doctest UserManager

  test "greets the world" do
    assert UserManager.hello() == :world
  end
end
