# Mips Simulator
Provides a command-line interface simulator of the MIPS assembly language in stateless, functional Elixir.

To use, make sure you have Elixir and Mix installed, then navigate into the mips directory and run `iex -S mix` to compile and open the project with the iex shell.

Provide a file containing MIPS code. See examples 1 and 2.

In the iex shell, specify starting register and memory maps, or use `Util.zero_regs` and `Utils.zero_mem` for empty ones.
See reg/mem states with `Util.print_state(regs, mem)`

Run your program file with `Util.parse_file("<filename>") |> Mips.run_instructions(<program size>, {Util.zero_regs, Util.zero_mem}) |> Util.print_state`.

## Example
Example2.txt provides a program that adds 5 to each element of an array with its base address stored at `s0` and its size at `s1`. 

## Notes
- Labels are not supported, use line number for branch instructions.
- Do not include dollar signs before registers.
- Only the most common instructions are currently supported.

## Installation

Later
