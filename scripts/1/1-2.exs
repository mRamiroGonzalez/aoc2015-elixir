
# AOC 2015 1-2

defmodule Aoc do
    def parseInput(_, acc \\ 0, pos \\ 1)
    def parseInput(_, -1, pos), do: IO.puts(pos - 1)
    def parseInput([40 | tail], acc, pos), do: parseInput(tail, acc + 1, pos + 1)
    def parseInput([41 | tail], acc, pos), do: parseInput(tail, acc - 1, pos + 1)
end

{:ok, file} = File.read("1-input.txt")
String.to_charlist(file) |> Aoc.parseInput()