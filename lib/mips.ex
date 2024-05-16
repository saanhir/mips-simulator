defmodule Mips do
  @moduledoc """
  Main multi-instruction execution module
  """

  @doc """
  Runs given formatted instructions. Returns final register map.
  """
  def run_instructions({instrs, size}, {regs, mem}) do
    # recursive anonymous closure
    exec = fn
      {regs, mem}, index, _ when index >= size -> {regs, mem}   # reached end of instructions -> return register & memory maps
      {regs, mem}, index, exec -> case elem(instrs, index) do
        # R-type
        [:add, dst, src, trg]   -> {%{regs | dst=> regs[src] + regs[trg]}, mem}       |> exec.(index+1, exec)
        [:sub, dst, src, trg]   -> {%{regs | dst=> regs[src] - regs[trg]}, mem}       |> exec.(index+1, exec)
        [:slt, dst, src, trg]   -> {%{regs | dst=> (if regs[src] < regs[trg], do: 1, else: 0)}, mem} |> exec.(index+1, exec)
        # I-type
        [:addi, trg, src, imm]  -> {%{regs | trg=> regs[src]+imm}, mem}               |> exec.(index+1, exec)
        [:li, trg, imm]         -> {%{regs | trg=> imm}, mem}                         |> exec.(index+1, exec)
        # Memory
        [:lw, trg, {src, imm}]  -> {%{regs | trg=> (if Map.has_key?(mem, regs[src]+imm), do: mem[regs[src]+imm], else: 0)}, mem } |> exec.(index+1, exec)
        [:sw, trg, {src, imm}]  -> {regs, Map.put(mem, regs[src] + imm, regs[trg])}   |> exec.(index+1, exec)
        # Branch
        [:bne, trg, src, imm]   -> {regs, mem}          |> exec.((if regs[trg] != regs[src], do: imm, else: index+1), exec)
        [:beq, trg, src, imm]   -> {regs, mem}          |> exec.((if regs[trg] == regs[src], do: imm, else: index+1), exec)

        _ -> "ERROR: Undefined Instruction"
      end
    end

    exec.({regs, mem}, 0, exec)
  end



end
