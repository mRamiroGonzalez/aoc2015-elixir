
# AOC 2015

defmodule Aoc do
    def parseInput(_, x1\\0, y1\\0, x2\\0, y2\\0, points \\ [[0,0]])
    def parseInput([], _, _, _, _, points), do: IO.puts length(Enum.uniq(points))
    def parseInput([s,r|t], x1, y1, x2, y2, points) do
        case {s,r} do
            {60, 60} ->
                x1 = x1 - 1
                x2 = x2 - 1
            {60, 94} ->
                x1 = x1 - 1
                y2 = y2 + 1
            {60, 62} ->
                x1 = x1 - 1
                x2 = x2 + 1
            {60, 118} ->
                x1 = x1 - 1
                y2 = y2 - 1
            {94, 94} ->
                y1 = y1 + 1
                y2 = y2 + 1
            {94, 60} ->
                x2 = x2 - 1
                y1 = y1 + 1
            {94, 62} ->
                x2 = x2 + 1
                y1 = y1 + 1
            {94, 118} ->
                y1 = y1 + 1
                y2 = y2 - 1            
            {62, 62} ->
                x1 = x1 + 1
                x2 = x2 + 1
            {62, 94} ->
                x1 = x1 + 1
                y2 = y2 + 1
            {62, 60} ->
                x1 = x1 + 1
                x2 = x2 - 1
            {62, 118} ->
                x1 = x1 + 1
                y2 = y2 - 1            
            {118, 118} ->
                y1 = y1 - 1
                y2 = y2 - 1        
            {118, 60} ->
                x2 = x2 - 1
                y1 = y1 - 1
            {118, 94} ->
                y1 = y1 - 1
                y2 = y2 + 1          
            {118, 62} ->
                x2 = x2 + 1
                y1 = y1 - 1
        end
        parseInput(t, x1, y1, x2, y2, points ++ [[x1,y1],[x2,y2]])
    end
end

{:ok, file} = File.read("3-input.txt")
String.to_charlist(file) |> Aoc.parseInput()
# < 60   ^ 94   > 62   v 118