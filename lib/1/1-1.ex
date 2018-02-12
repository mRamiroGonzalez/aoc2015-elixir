
# AOC 2015 1-1

defmodule Aoc2015.One.One do
    def parseInput(_, acc \\ 0)
    def parseInput([], acc), do: IO.puts(acc)
    def parseInput([40 | tail], acc), do: parseInput(tail, acc + 1)
    def parseInput([41 | tail], acc), do: parseInput(tail, acc - 1)

    def start do
        {:ok, file} = File.read("lib/1/1-input.txt")
        String.to_charlist(file) |> parseInput()   
    end
end