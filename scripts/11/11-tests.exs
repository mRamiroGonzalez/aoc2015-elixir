
defmodule Test do

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
end

IO.inspect Test.hasThreeIncreasingLetters(String.to_charlist "zzabcrt")
IO.inspect Test.hasThreeIncreasingLetters(String.to_charlist "azefrgty")
IO.inspect Test.hasThreeIncreasingLetters(String.to_charlist "ab")
IO.puts ""
IO.inspect Test.doesNotHaveForbidenLetters("azerty")
IO.inspect Test.doesNotHaveForbidenLetters("azorty")
IO.inspect Test.doesNotHaveForbidenLetters("aierly")
IO.puts ""
IO.inspect Test.hasTwoPairsOfLetters("azerttyuiiop")
IO.inspect Test.hasTwoPairsOfLetters("azertyuiop")
IO.inspect Test.hasTwoPairsOfLetters("aaaa")
IO.puts ""
IO.inspect (Test.hasThreeIncreasingLetters("hijklmmn") and Test.doesNotHaveForbidenLetters("hijklmmn") and Test.hasTwoPairsOfLetters("hijklmmn"))
IO.inspect (Test.hasThreeIncreasingLetters("abbceffg") and Test.doesNotHaveForbidenLetters("abbceffg") and Test.hasTwoPairsOfLetters("abbceffg"))
IO.inspect (Test.hasThreeIncreasingLetters("abbcegjk") and Test.doesNotHaveForbidenLetters("abbcegjk") and Test.hasTwoPairsOfLetters("abbcegjk"))