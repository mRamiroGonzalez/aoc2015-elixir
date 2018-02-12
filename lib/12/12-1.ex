
defmodule Aoc2015.Twelve.One do
    def getSumOfNumbers(string) do
        Regex.scan(~r/\-*\d+/, string) 
        |> List.flatten
        |> Enum.map(fn(x) -> String.to_integer(x) end) 
        |> Enum.sum
        |> IO.inspect
    end

    def start do        
        File.read!("lib/12/12-input.txt") |> getSumOfNumbers     
    end
end