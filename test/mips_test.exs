defmodule MipsTest do
  use ExUnit.Case
  doctest Single

  # Single instruction tests.

  # Load immediate
  test "Single-li" do
    assert (Single.exec([:li, :s0, 5], Util.zero_state) |> elem(0))[:s0] == 5
  end

  # Store word
  test "Single, sw" do
    assert (Single.exec([:sw, :s1, :s0, 0], {%{s0: 5, s1: 16}, Util.zero_mem}) |> elem(1))[5] == 16
  end


end
