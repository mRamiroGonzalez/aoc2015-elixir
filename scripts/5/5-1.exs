
# AOC 2015 5-1

defmodule Aoc do

    @voyels "aeiou"
    @bad_strings ["ab","cd","pq","xy"]

    def parseInput([], acc), do: IO.puts acc    
    def parseInput([h|t], acc) do
        if (check_three_voyels(h) && check_bad_string(h) && check_double_letter(String.to_charlist(h))) do
            parseInput(t, acc+1)
        else
            parseInput(t, acc)
        end
    end

    def check_three_voyels(word) do
        nb = Enum.count String.split(word,""), fn l ->
            @voyels =~ l
        end
        (nb - 1) > 2
    end

    def check_bad_string(s) do
        !Enum.any? @bad_strings, fn b ->
            s =~ b
        end
    end

    def check_double_letter(_, nb \\ 0)
    def check_double_letter([], nb), do: nb > 0
    def check_double_letter([a,b|t], nb) do
        if (a == b) do
            check_double_letter([[b] ++ t], nb+1)
        else
            check_double_letter([b] ++ t, nb)
        end
    end
    def check_double_letter([_|t], nb), do: check_double_letter(t, nb)

end

{:ok, file} = File.read("5-input.txt")
String.split(file, "\n") |> Aoc.parseInput(0)