defmodule MipsTest do
  use ExUnit.Case
  doctest Single


  test "Single instruction, load immediate test" do
    assert (Single.exec([:li, :s0, 5], {Util.zero_regs, Util.zero_mem}) |> elem(0))[:s0] == 5
  end

  test "Single instruction, store to mem test" do
    assert (Single.exec([:sw, :s1, :s0, 0], {%{s0: 5, s1: 16}, Util.zero_mem}) |> elem(1))[5] == 16
  end
end
