defmodule CLI do
  import Util

  def main(args) do
    case args do
      #[filename] -> IO.puts("printin: " <> filename)
      [filename] -> parse_file(filename) |> Mips.run_instructions(zero_state()) |> print_state
      _ -> IO.puts("Format: ./exe <filename>")
    end
  end
end
