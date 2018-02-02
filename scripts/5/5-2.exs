
# AOC 2015 5-2

defmodule Aoc do

    @rule1 ~r/([a-zA-Z]{2}).*\1/
    @rule2 ~r/([a-zA-Z]).\1/

    def parseInput(list) do
        nb = Enum.count list, fn e ->
            Regex.match?(@rule1, e) && Regex.match?(@rule2, e)
        end
        IO.puts nb
    end
end

{:ok, file} = File.read("5-input.txt")
String.split(file, "\n") |> Aoc.parseInput()