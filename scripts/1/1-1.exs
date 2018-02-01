
# AOC 2015 1-1

defmodule Aoc do
    def parseInput(_, acc \\ 0)
    def parseInput([], acc), do: IO.puts(acc)
    def parseInput([40 | tail], acc), do: parseInput(tail, acc + 1)
    def parseInput([41 | tail], acc), do: parseInput(tail, acc - 1)
end

{:ok, file} = File.read("1-input.txt")
String.to_charlist(file) |> Aoc.parseInput()