
defmodule Aoc2015.Fourteen.Two do

  def parseInstructions(lines) do
    Enum.reduce(lines, [], fn (line, acc) ->
      words = String.split(line, " ")
      entry =
        %{}
        |> Map.put(:name, Enum.at(words, 0))
        |> Map.put(:speed, String.to_integer(Enum.at(words, 3)))
        |> Map.put(:stamina, String.to_integer(Enum.at(words, 6)))
        |> Map.put(:recover, String.to_integer(Enum.at(words, 13)))
      [entry | acc]
    end)
  end

  def findFirstAt(instructions, limit) do
    IO.inspect(instructions)
    IO.inspect(limit)
  end

  def start do
    File.read!("lib/14/14-input-test.txt") |> String.split("\n") |> parseInstructions |> findFirstAt(1000)
#    File.read!("lib/14/14-input.txt") |> String.split("\n") |> parseInstructions |> findFirstAt(2503)
  end
end