
defmodule Aoc do
    def getSumOfNumbers(string) do
        Regex.scan(~r/\-*\d+/, string) 
        |> List.flatten
        |> Enum.map(fn(x) -> String.to_integer(x) end) 
        |> Enum.sum
        |> IO.inspect
    end
end

File.read!("12-input.txt") |> Aoc.getSumOfNumbers