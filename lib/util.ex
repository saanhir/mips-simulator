defmodule Util do

  def parse_file(filename) do
    File.read(filename)
    |> elem(1) # get 1st element of tuple
    |> String.replace(",", "")
    |> String.split("\n")  # split by instruction
    |> Enum.map(fn str -> String.split(str) end)  # split by symbol
    |> then(fn total -> (for line <- total, do: Enum.map(line, fn sym -> parse_symbol(sym) end)) end) # parse instruction symbols
    |> List.to_tuple()
    |> then(fn tup -> {tup, tuple_size(tup)} end)
  end


  def parse_symbol(symbol) do
    case Integer.parse symbol do
      {int, ""} -> int
      {int, str} -> {(String.slice(str, 1, 2) |> String.to_atom), int}
      :error -> String.to_atom(symbol)
    end
  end

  def parse_init(filename) do
    File.read(filename)
    |> elem(1) # get 1st element of tuple
    |> String.replace(",", "")
    |> String.split("\n")  # split by instruction
    |> Enum.map(fn str -> String.split(str, "=") end)  # split by symbol
    |> Enum.reduce(zero_state(), fn line, {regs, mem} ->
      k = parse_symbol(hd line)
      v = parse_symbol(hd tl line)
      if Map.has_key?(regs, k) do
        {%{regs | k => v}, mem}
      else
        {regs, Map.put(mem, k, v)}
      end

    end)
  end



  def zero_regs do
    %{zero: 0, at: 0, s0: 0, s1: 0, s2: 0, s3: 0, t0: 0, t1: 0, t2: 0, t3: 0}
  end

  def zero_mem do
    %{}
  end

  def zero_state do
    {zero_regs(), zero_mem()}
  end

  def print_state({r, m}) do
    IO.puts("=========REGISTERS===========")
    Enum.reduce(r, "", fn {k,v}, acc -> acc <> "$ #{k} --- #{v}\n" end)
    |> IO.puts
    IO.puts("=========MEMORY===========")
    Enum.reduce(m, "", fn {k,v}, acc -> acc <> "x #{k} --- #{v}\n" end)
    |> IO.puts
  end


end
