
defmodule Aoc2015.Fourteen.One do

  def parseInstructions(lines) do
    Enum.reduce(lines, [], fn (x, acc) ->
      words = String.split(x, " ")
      entry =
        %{}
        |> Map.put(:name, Enum.at(words, 0))
        |> Map.put(:speed, Enum.at(words, 3))
        |> Map.put(:stamina, Enum.at(words, 6))
        |> Map.put(:recover, Enum.at(words, 13))
      [entry | acc]
    end)
  end

  def start do
    File.read!("lib/14/14-input.txt") |> String.split("\n") |> parseInstructions |> IO.inspect()
  end
end