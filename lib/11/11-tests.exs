
defmodule Aoc2015.Eleven.Test do

    # Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz.
    # They cannot skip letters: abd doesn't count.
    def hasThreeIncreasingLetters([_, _]), do: false
    def hasThreeIncreasingLetters([a, b, c | t]) do
        if ((a == b - 1) and (a == c - 2)) do
            true
        else
            hasThreeIncreasingLetters([b, c | t])
        end
    end
    def hasThreeIncreasingLetters(word), do: word |> String.to_charlist |> hasThreeIncreasingLetters
    
    # Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are therefore confusing.
    def doesNotHaveForbidenLetters(word) do
        not (String.contains?(word, "i") or String.contains?(word, "o") or String.contains?(word, "l"))
    end

    # Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
    def hasTwoPairsOfLetters(word) do
        scan = Regex.scan(~r/(.)\1/, word)
        (length(scan)) >= 2 and (Enum.at(scan, 0) != Enum.at(scan, 1))
    end

    def start do   
        IO.inspect hasThreeIncreasingLetters(String.to_charlist "zzabcrt")
        IO.inspect hasThreeIncreasingLetters(String.to_charlist "azefrgty")
        IO.inspect hasThreeIncreasingLetters(String.to_charlist "ab")
        IO.puts ""
        IO.inspect doesNotHaveForbidenLetters("azerty")
        IO.inspect doesNotHaveForbidenLetters("azorty")
        IO.inspect doesNotHaveForbidenLetters("aierly")
        IO.puts ""
        IO.inspect hasTwoPairsOfLetters("azerttyuiiop")
        IO.inspect hasTwoPairsOfLetters("azertyuiop")
        IO.inspect hasTwoPairsOfLetters("aaaa")
        IO.puts ""
        IO.inspect (hasThreeIncreasingLetters("hijklmmn") and doesNotHaveForbidenLetters("hijklmmn") and hasTwoPairsOfLetters("hijklmmn"))
        IO.inspect (hasThreeIncreasingLetters("abbceffg") and doesNotHaveForbidenLetters("abbceffg") and hasTwoPairsOfLetters("abbceffg"))
        IO.inspect (hasThreeIncreasingLetters("abbcegjk") and doesNotHaveForbidenLetters("abbcegjk") and hasTwoPairsOfLetters("abbcegjk"))     
    end
end