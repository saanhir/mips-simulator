defmodule CLI do
  import Util

  def main(args) do
    case args do
      [instr_file] -> parse_file(instr_file) |> Mips.run_instructions(zero_state()) |> print_state
      [instr_file, init_file] -> parse_file(instr_file) |> Mips.run_instructions(parse_init(init_file)) |> print_state
      _ -> IO.puts("Format: ./exe <filename>")
    end
  end
end
