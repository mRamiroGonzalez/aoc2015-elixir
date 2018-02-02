
# AOC 2015 3-1

defmodule Aoc do
    def parseInput(_, x \\ 0, y \\ 0, points \\ [[0,0]])
    def parseInput([], _, _, points), do: IO.puts length(Enum.uniq(points))
    def parseInput([60|t], x, y, points), do: parseInput(t, x-1, y, points ++ [[x-1,y]])
    def parseInput([62|t], x, y, points), do: parseInput(t, x+1, y, points ++ [[x+1,y]])
    def parseInput([94|t], x, y, points), do: parseInput(t, x, y+1, points ++ [[x,y+1]])
    def parseInput([118|t], x, y, points), do: parseInput(t, x, y-1, points ++ [[x,y-1]])
end

{:ok, file} = File.read("3-input.txt")
String.to_charlist(file) |> Aoc.parseInput()
# < 60   ^ 94   > 62   v 118