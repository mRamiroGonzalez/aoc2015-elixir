
# AOC 2015 5-2

defmodule Aoc2015.Five.Two do

    @rule1 ~r/([a-zA-Z]{2}).*\1/
    @rule2 ~r/([a-zA-Z]).\1/

    def parseInput(list) do
        IO.puts Enum.count list, fn e ->
            Regex.match?(@rule1, e) && Regex.match?(@rule2, e)
        end
    end

    def start do
        {:ok, file} = File.read("lib/5/5-input.txt")
        String.split(file, "\n") |> parseInput()     
    end
end