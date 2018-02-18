
defmodule Aoc2015.Fourteen.One do

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
    positions =
      Enum.reduce(instructions, [], fn (reindeer, acc) ->
        [%{name: reindeer.name, distance: getPositionAt(reindeer, limit)} | acc]
      end)
    bestReindeer =
      Enum.reduce(positions, 0, fn (reindeer, acc) ->
        if (reindeer.distance > acc), do: reindeer.distance, else: acc
      end)
    IO.puts("Distance of the best reindeer ever: #{bestReindeer}")
  end

  def getPositionAt(reindeer, limit, nbStep \\ 1, dist \\ 0, state \\ :sleeping, remaining \\ 0)
  def getPositionAt(_reindeer, limit, limit, dist, _, _), do: dist
  def getPositionAt(reindeer, limit, nbStep, dist, state, remaining) do
    case state do
      :running ->
        if (remaining == 0) do
          getPositionAt(reindeer, limit, nbStep + 1, dist, :sleeping, reindeer.recover - 1)
        else
          getPositionAt(reindeer, limit, nbStep + 1, dist + reindeer.speed, :running, remaining - 1)
        end
      :sleeping ->
        if (remaining == 0) do
          getPositionAt(reindeer, limit, nbStep + 1, dist + reindeer.speed, :running, reindeer.stamina - 1)
        else
          getPositionAt(reindeer, limit, nbStep + 1, dist, :sleeping, remaining - 1)
        end
    end
  end

  def start do
    File.read!("lib/14/14-input.txt") |> String.split("\n") |> parseInstructions |> findFirstAt(2503)
  end
end