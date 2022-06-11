defmodule KeebsTest do
  use ExUnit.Case
  doctest Keebs

  test "greets the world" do
    assert Keebs.hello() == :world
  end
end
