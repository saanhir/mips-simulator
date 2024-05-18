defmodule CLI do
  @moduledoc """
  Command-line interface for the simulator. Here the executable begins.
  """
  import Util

  @doc """
  Main function for parsing command-line args.
  """
  def main(args) do
    case args do
      [instr_file] -> parse_file(instr_file) |> Mips.run_instructions(zero_state()) |> print_state
      [instr_file, init_file] -> parse_file(instr_file) |> Mips.run_instructions(parse_init(init_file)) |> print_state
      _ -> IO.puts("Format: ./exe <instruction file> [initia state file]")
    end
  end
end
