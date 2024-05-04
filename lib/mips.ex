defmodule Mips do
  @moduledoc """
  Main multi-instruction execution module
  """

  @doc """
  Runs given formatted instructions. Returns final register map.
  """
  def run_instructions(instrs, size, regs) do
    # recursive anonymous closure
    exec = fn
      regs, index, _ when index >= size -> regs   # reached end of instructions -> return register map
      regs, index, exec -> case elem(instrs, index) do
        # R-type
        [:add, dst, src, trg]   -> exec.(%{regs | dst=> regs[src] + regs[trg]}, index+1, exec)
        [:sub, dst, src, trg]   -> exec.(%{regs | dst=> regs[src] - regs[trg]}, index+1, exec)
        #[:slt, dst, src, trg]   -> exec.(%{regs | dst=> if regs[]})
        # I-type
        [:addi, trg, src, imm]  -> exec.(%{regs | trg=> regs[src]+imm}, index+1, exec)
        [:li, trg, imm]         -> exec.(%{regs | trg=> imm}, index+1, exec)
        # Branch
        [:bne, trg, src, imm]   -> if regs[trg] != regs[src], do: exec.(regs, imm, exec), else: exec.(regs, index+1, exec)
        _ -> "ERROR: Undefined Instruction"
      end
    end

    exec.(regs, 0, exec)
  end



end
