defmodule Mips do
  @moduledoc """
  Documentation for `Mips`.
  """

  def main(filename) do
    regs = %{s0: 0, s1: 0, s2: 0}
    print_regs(regs)
    IO.puts("--Running--")
    exec(regs, parse_file(filename), 5, 0) |> print_regs

  end

  def print_regs(r) do
    IO.puts("====================")
    for {k, v} <- r, do: IO.puts("$ #{k}  --- #{v}")
    IO.puts("====================")

  end

  def parse_file(filename) do
    File.read(filename)
    |> then(fn x -> elem x, 1 end) # get 1st element of tuple
    |> String.replace(",", "")
    |> then(fn x -> String.split(x, "\n") end)  # split by instruction
    |> Enum.map(fn str -> String.split(str) end)  # split by symbol
    |> then(fn total -> (for line <- total, do: Enum.map(line, fn sym -> Mips.parse_symbol(sym) end)) end) # parse instruction symbols
    |> List.to_tuple()

  end

  def parse_symbol(symbol) do
    case Integer.parse symbol do
      {int, _} -> int
      :error -> String.to_atom(symbol)
    end
  end

  @doc """
  Run an instruction
  """
  def exec1(instr, regs) do # list

    case instr do
      [:add, dst, src, trg]   -> %{regs | dst=> regs[src]+regs[trg]}
      [:addi, trg, src, imm]  -> %{regs | trg=> regs[src]+imm}
      [:subi, trg, src, imm]  -> %{regs | trg=> regs[src]-imm}
      [:li, trg, imm]         -> %{regs | trg=> imm}
      [:move, trg, src]       -> %{regs | trg=> regs[src]}
      _ -> "Error"
    end

  end

  def flow(instrs, size, regs) do

    run = fn
      regs, ix, _ when ix >= size -> regs
      regs, ix, run -> case elem(instrs, ix) do
        [:add, dst, src, trg]   -> run.(%{regs | dst=> regs[src]+regs[trg]}, ix+1, run)
        [:addi, trg, src, imm]  -> run.(%{regs | trg=> regs[src]+imm}, ix+1, run)
        [:li, trg, imm]         -> run.(%{regs | trg=> imm}, ix+1, run)
        [:bne, trg, src, imm]   -> if regs[trg] != regs[src], do: run.(regs, imm, run), else: run.(regs, ix+1, run)
        _ -> "Instruction Error"
      end
      _, _, _ -> "Run error"
    end

    run.(regs, 0, run)


  end

  def exec(regs, instrs, size, index) do
    # base case
    if index >= size do
      regs
    else
      #IO.puts(index)
      case elem(instrs, index) do
        [:add, dst, src, trg]   -> exec %{regs | dst=> regs[src]+regs[trg]}, instrs, size, index+1
        [:addi, trg, src, imm]  -> exec %{regs | trg=> regs[src]+imm}, instrs, size, index+1
        [:li, trg, imm]         -> exec %{regs | trg=> imm}, instrs, size, index+1
        [:bne, trg, src, imm]   -> if regs[trg] != regs[src], do: exec(regs, instrs, size, imm), else: exec(regs, instrs, size, index+1)
        _ -> "Error"
      end

    end
  end

#   Mips.exec [:addi, :s1, :zero, 15],
# regs = %{zero: 0, s0: 0, s1: 0, s2: 0}

end
