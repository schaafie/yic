defmodule VersionManagerTest do
  use ExUnit.Case
  doctest VersionManager

  test "greets the world" do
    assert VersionManager.hello() == :world
  end
end
