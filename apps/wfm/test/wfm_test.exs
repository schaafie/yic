defmodule WfmTest do
  use ExUnit.Case
  doctest Wfm

  test "greets the world" do
    assert Wfm.hello() == :world
  end
end
