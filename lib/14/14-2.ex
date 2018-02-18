
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
        |> Map.put(:state, :sleeping)
        |> Map.put(:dist, 0)
        |> Map.put(:remaining, 0)
        |> Map.put(:score, 0)
      [entry | acc]
    end)
  end

  def findFirstAt(reindeers, limit, nbSteps \\ 1)
  def findFirstAt(reindeers, limit, limit) do
    bestScore =
      Enum.reduce(reindeers, 0, fn (reindeer, acc) ->
        if (reindeer.score > acc), do: reindeer.score, else: acc
      end)
    IO.puts "Score of the new best reindeer ever is: #{bestScore}"
  end
  def findFirstAt(reindeers, limit, nbSteps) do
    reindeers
    |> doOneStep
    |> updateScores
    |> findFirstAt(limit, nbSteps + 1)
  end

  def updateScores(reindeers) do
    bestScore =
      Enum.reduce(reindeers, 0, fn (reindeer, acc) ->
        if (reindeer.dist > acc), do: reindeer.dist, else: acc
      end)
    Enum.reduce(reindeers, [], fn (reindeer, acc) ->
      updatedReindeer =
        if (reindeer.dist == bestScore) do
          Map.put(reindeer, :score, reindeer.score + 1)
        else
          reindeer
        end
      [updatedReindeer | acc]
    end)
  end

  def doOneStep(reindeers) do
    Enum.reduce(reindeers, [], fn (reindeer, acc) ->
      updatedReindeer =
        if (reindeer.state == :running) do
          if (reindeer.remaining == 0) do
            reindeer
            |> Map.put(:state, :sleeping)
            |> Map.put(:remaining, reindeer.recover - 1)
          else
            reindeer
            |> Map.put(:dist, reindeer.dist + reindeer.speed)
            |> Map.put(:remaining, reindeer.remaining - 1)
          end
        else
          if (reindeer.remaining == 0) do
            reindeer
            |> Map.put(:state, :running)
            |> Map.put(:dist, reindeer.dist + reindeer.speed)
            |> Map.put(:remaining, reindeer.stamina - 1)
          else
            reindeer
            |> Map.put(:state, :sleeping)
            |> Map.put(:remaining, reindeer.remaining - 1)
          end
        end
      [updatedReindeer | acc]
    end)
  end

  def start do
#    File.read!("lib/14/14-input-test.txt") |> String.split("\n") |> parseInstructions |> findFirstAt(1000)
    File.read!("lib/14/14-input.txt") |> String.split("\n") |> parseInstructions |> findFirstAt(2503)
  end
end