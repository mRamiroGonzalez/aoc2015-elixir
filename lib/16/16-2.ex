
defmodule Aoc2015.Sixteen.Two do

  @toFind %{children: 3, cats: 7, samoyeds: 2, pomeranians: 3, akitas: 0, vizslas: 0, goldfish: 5, trees: 3, cars: 2, perfumes: 1}

  def findAunt(list) do
    Enum.reduce getScores(list), {}, fn (x, acc) ->
      if (acc == {}) do
        x
      else
        {_, score} = x
        {_, max} = acc
        if (score > max), do: x, else: acc
      end
    end
  end

  def getScores(auntsList) do
    Enum.reduce auntsList, [], fn (x, acc) ->
      score =
        Map.merge(x, @toFind, fn(k, v1, v2) ->
          if (k == :cats or k == :trees) do
            if (v2 < v1), do: :true, else: :false
          else
            if (k == :pomeranians or k == :goldfish) do
              if (v2 > v1), do: :true, else: :false
            else
              if (v1 == v2), do: :true, else: :false
            end
          end
        end)
        |> Map.values
        |> Enum.count(fn(x) -> x == :true end)
      [{x.sue, score} | acc]
    end
  end

  def parseInput(lines) do
    Enum.reduce lines, [], fn (line, acc) ->
      words = String.split(line," ")
      instruction = parseWords(words)
      [instruction | acc]
    end
  end

  def parseWords(words) do
    test = Enum.chunk_every(words, 2)
    Enum.reduce(test, %{}, fn ([name | number], acc) ->
      Map.put(
        acc,
        name |> String.downcase |> String.to_atom,
        number |> Enum.at(0) |> String.to_integer)
    end)
  end

  def cleanAndSplit(file) do
    file
    |> String.replace(":","")
    |> String.replace(",","")
    |> String.split("\n")
  end

  def start() do
    File.read!("lib/16/16-input.txt")
    |> cleanAndSplit
    |> parseInput
    |> findAunt
    |> IO.inspect
  end
end