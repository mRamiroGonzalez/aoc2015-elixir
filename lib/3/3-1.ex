
# AOC 2015 3-1

defmodule Aoc2015.Three.One do
    
    # < 60   ^ 94   > 62   v 118
    
    def parseInput(_, x \\ 0, y \\ 0, points \\ [[0,0]])
    def parseInput([], _, _, points), do: IO.puts length(Enum.uniq(points))
    def parseInput([60|t], x, y, points), do: parseInput(t, x-1, y, points ++ [[x-1,y]])
    def parseInput([62|t], x, y, points), do: parseInput(t, x+1, y, points ++ [[x+1,y]])
    def parseInput([94|t], x, y, points), do: parseInput(t, x, y+1, points ++ [[x,y+1]])
    def parseInput([118|t], x, y, points), do: parseInput(t, x, y-1, points ++ [[x,y-1]])

    def start do
        {:ok, file} = File.read("lib/3/3-input.txt")
        String.to_charlist(file) |> parseInput()
    end
end