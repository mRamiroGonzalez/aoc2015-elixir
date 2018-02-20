defmodule Aoc2015Test do
  use ExUnit.Case
  doctest Aoc2015

  IO.puts "Starting AOC 2015 script"
  start = :os.system_time(:millisecond)

  Aoc2015.Sixteen.One.start()

  stop = :os.system_time(:millisecond)
  IO.puts "Took #{(stop - start) / 1000} seconds\n"
end
