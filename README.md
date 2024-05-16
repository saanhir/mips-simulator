# Mips Simulator
Provides a command-line interface simulator of the MIPS assembly language in stateless, functional Elixir.

## Installation
Clone the repo into local or download `exe` file. In either case, make sure you have Erlang VM / BEAM installed.

## Usage
There are two ways to use this simulator: 1) with the `iex` shell, or 2) with the executable.
1. Make sure you have Elixir and Mix installed, then navigate into the mips directory and run `iex -S mix` to compile and open the project with the iex shell. Provide a file containing MIPS code. See examples 1 and 2.
In the iex shell, specify starting register and memory maps, or use `Util.zero_state` for empty maps.
Run your program file with `Util.parse_file("<filename>") |> Mips.run_instructions(Util.zero_state) |> Util.print_state`.

2. Use the CLI executable `exe`, providing the MIPS instructions file name as the only argument: `./exe <filename>`. Note that presently this method always starts with a zero state.

## Examples
1. `example1.txt` is a MIPS program that loads 1 into s1 and 5 into s2, then runs a loop decrementing s1 and incrementing s2 until they are equal.
2. `example2.txt` provides a program that adds 5 to each element of a memory-contiguous array with its base address stored at `s0` and its size at `s1`.

## Notes
- Labels are not supported, use line number (0-indexed) for branch instructions.
- Do not include dollar signs before registers.
- Only the most common instructions are currently supported.
