
# AOC 2015 11-1 & 11-2

defmodule Aoc2015.Eleven.OneTwo do
    
    @firstLetter 97
    @lastLetter 122

    def getNextPassword(current)do
        if (hasThreeIncreasingLetters(current) and doesNotHaveForbidenLetters(current) and hasTwoPairsOfLetters(current)) do
            IO.puts "Correct password: #{current}"
        else
            getNextPassword(incrementPassword(current))
        end
    end

    def incrementPassword(current) do
        current
        |> String.to_charlist 
        |> Enum.reverse
        |> incrementCharacter
        |> Enum.reverse
        |> List.to_string
    end

    def incrementCharacter(list) do
        [h|t] = list
        if(h == @lastLetter) do
            [@firstLetter | incrementCharacter(t)]
        else
            [h + 1 | t]
        end
    end

    def hasThreeIncreasingLetters([_, _]), do: false
    def hasThreeIncreasingLetters([a, b, c | t]) do
        if ((a == b - 1) and (a == c - 2)) do
            true
        else
            hasThreeIncreasingLetters([b, c | t])
        end
    end
    def hasThreeIncreasingLetters(word), do: word |> String.to_charlist |> hasThreeIncreasingLetters
    
    def doesNotHaveForbidenLetters(word) do
        not String.contains?(word, ["i", "o", "l"])
    end

    def hasTwoPairsOfLetters(word) do
        scan = Regex.scan(~r/(.)\1/, word)
        (length(scan)) >= 2 and (Enum.at(scan, 0) != Enum.at(scan, 1))
    end

    def start do
        getNextPassword("hxbxwxba")
        getNextPassword(incrementPassword("hxbxxyzz"))
    end
end