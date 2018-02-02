
# AOC 2015 5-1

defmodule Aoc do

    def parseInput([], acc), do: IO.puts acc    
    def parseInput([h|t], acc) do
        
    end
end

{:ok, file} = File.read("5-input.txt")
String.split(file, "\n") |> Aoc.parseInput(0)