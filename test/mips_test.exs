defmodule MipsTest do
  use ExUnit.Case
  doctest Mips

  test "greets the world" do
    assert Mips.hello() == :world
  end
end
