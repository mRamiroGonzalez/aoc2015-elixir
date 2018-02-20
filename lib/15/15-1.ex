
defmodule Aoc2015.Fifteen.OneTwo do

  @filePath "lib/15/recipes.txt"

  def parseInput(lines) do
    Enum.reduce(lines, %{}, fn (line, acc) ->
      words = String.split(line, " ")
      ingredient =
        %{}
        |> Map.put(:capacity, String.to_integer(Enum.at(words, 2)))
        |> Map.put(:durability, String.to_integer(Enum.at(words, 4)))
        |> Map.put(:flavor, String.to_integer(Enum.at(words, 6)))
        |> Map.put(:texture, String.to_integer(Enum.at(words, 8)))
        |> Map.put(:calories, String.to_integer(Enum.at(words, 10)))
      Map.put(acc, String.to_atom(String.downcase(Enum.at(words, 0))), ingredient)
    end)
  end

  def getScoresFromFile() do
    numbersAsStrings = File.read!(@filePath) |> String.split("\n")

    numbers = Enum.reduce numbersAsStrings, [], fn (x, acc) ->
      if (x != "") do
        [String.to_integer(x) | acc]
      else
        acc
      end
    end

    IO.inspect(Enum.max(numbers))
  end

  def createRecipes(instructions, limit)do
    Enum.each 0..limit, fn a ->
      Enum.each 0..limit, fn b ->
        Enum.each 0..limit, fn c ->
          Enum.each 0..limit, fn d ->
            if(a + b + c + d == limit) do
              saveToFile getRecipeScore([a,b,c,d], instructions)
            end
          end
        end
      end
    end
  end

  def getRecipeScore(recipe, instructions) do
    scoreCapacity = getScoreFor(instructions, recipe, :capacity)
    scoreDurability = getScoreFor(instructions, recipe, :durability)
    scoreFlavor = getScoreFor(instructions, recipe, :flavor)
    scoreTexture = getScoreFor(instructions, recipe, :texture)
    scoreCalories = getScoreFor(instructions, recipe, :calories)

    if (scoreCalories >= 500), do: (scoreCapacity * scoreDurability * scoreFlavor * scoreTexture), else: 0

  end

  def getScoreFor(instructions, [frosting, peanutButter, sprinkles, sugar], stat) do
    score =
      (instructions.frosting[stat] * frosting) +
      (instructions.peanutbutter[stat] * peanutButter) +
      (instructions.sprinkles[stat] * sprinkles) +
      (instructions.sugar[stat] * sugar)
    if (score < 0), do: 0, else: score
  end

  def saveToFile(elem) do
    File.open!(@filePath, [:append])
    |> IO.write((inspect elem) <> "\n" )
    |> File.close
  end

  def start do
    File.rm(@filePath)
    File.read!("lib/15/15-input.txt") |> String.replace(":","") |> String.replace(",","") |> String.split("\n")
    |> parseInput
    |> createRecipes(100)
    getScoresFromFile()
    File.rm(@filePath)
  end
end