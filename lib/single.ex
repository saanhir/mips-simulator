defmodule Single do
  @moduledoc """
  Module for executing a single MIPS instruction, rather than a full program.
  Use for testing with the iex shell.
  """

  @doc """
  Params: {register map, memory map}
  Returns: {register map, memory map}
  """
  def exec instr, {regs, mem} do
    case instr do
      # R-type
      [:add, dst, src, trg]   -> { %{regs | dst=> regs[src] + regs[trg]}, mem }
      [:sub, dst, src, trg]   -> { %{regs | dst=> regs[src] - regs[trg]}, mem }
      [:slt, dst, src, trg]   -> { %{regs | dst=> (if regs[src] < regs[trg], do: 1, else: 0)}, mem }
      # I-type
      [:addi, trg, src, imm]  -> { %{regs | trg=> regs[src] + imm}, mem }
      [:li, trg, imm]         -> { %{regs | trg=> imm}, mem }
      # Branch -- UNUSABLE

      # Memory
      [:lw, trg, src, imm]    -> { %{regs | trg=> (if Map.has_key?(mem, regs[src] + imm), do: mem[regs[src]+imm], else: 0)}, mem }
      [:sw, trg, src, imm]    -> { regs, Map.put(mem, regs[src]+imm, regs[trg]) }

      # This instruction is dedicated
      # to the brave fighters of Indela's CSE 230
      [:subi, trg, src, imm]  -> { %{regs | trg=> regs[src] - imm}, mem }
      _   -> "ERROR: Undefined Instruction"
    end
  end

end
