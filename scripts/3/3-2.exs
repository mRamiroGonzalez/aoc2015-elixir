
# AOC 2015 3-2

defmodule Aoc do

    @directions_map %{60 => -1, 62 => 1, 94 => 1, 118 => -1}

    def parseInput(_, x1\\0, y1\\0, x2\\0, y2\\0, points\\[[0,0]])
    def parseInput([], _, _, _, _, points), do: IO.puts length(Enum.uniq(points))
    def parseInput([s,r|t], x1, y1, x2, y2, points) do        
        {x1, y1} = processDirections(s, x1, y1)
        {x2, y2} = processDirections(r, x2, y2)
        parseInput(t, x1, y1, x2, y2, points ++ [[x1,y1],[x2,y2]])
    end

    def processDirections(dir, x, y) do
        if (dir in [60,62]) do
            {x + @directions_map[dir], y}
        else
            {x, y + @directions_map[dir]}
        end
    end
end

{:ok, file} = File.read("3-input.txt")
String.to_charlist(file) |> Aoc.parseInput()
# < 60   ^ 94   > 62   v 118