
# AOC 2015

defmodule Aoc do
    def parseInput(_, x1\\0, y1\\0, x2\\0, y2\\0, points\\[[0,0]])
    def parseInput([], _, _, _, _, points), do: IO.puts length(Enum.uniq(points))
    def parseInput([s,r|t], x1, y1, x2, y2, points) do
        map = %{60 => -1, 62 => 1, 94 => 1, 118 => -1}
        
        if (s in [60,62]) do
            x1 = x1 + map[s]
        else
            y1 = y1 + map[s]
        end
        if (r in [60,62]) do
            x2 = x2 + map[r]
        else
            y2 = y2 + map[r]
        end
        
        parseInput(t, x1, y1, x2, y2, points ++ [[x1,y1],[x2,y2]])
    end
end

{:ok, file} = File.read("3-input.txt")
String.to_charlist(file) |> Aoc.parseInput()
# < 60   ^ 94   > 62   v 118