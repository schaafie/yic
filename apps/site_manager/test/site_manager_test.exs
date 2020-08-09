defmodule SiteManagerTest do
  use ExUnit.Case
  doctest SiteManager

  test "greets the world" do
    assert SiteManager.hello() == :world
  end
end
