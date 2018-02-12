
# AOC 2015 6-2

defmodule Aoc2015.Six.Two do

    def parse_input(list, 0) do
        line = Enum.reduce 0..999, %{}, fn x, acc -> Map.put(acc, x, 0) end
        grid = Enum.reduce 0..999, %{}, fn x, acc -> Map.put(acc, x, line) end
        parse_input(list, grid)
    end
    def parse_input([h|t], grid) do
        {i, s1, s2, f1, f2} = get_instructions(h)
        grid = process_instruction(grid, i, s1, s2, f1, f2)
        parse_input(t, grid)
    end
    def parse_input([], grid) do
        nb = Enum.reduce grid, 0, fn {_,line}, acc ->
            acc + Enum.reduce line, 0, fn {_, cell}, acc2 ->
                acc2 + cell
            end
        end
        IO.puts nb
    end

    def process_instruction(grid, i, x1, y1, x2, y2) do
        IO.puts "Do:#{i} From:(#{x1},#{y1}) To:(#{x2},#{y2})"  
        case i do
            "toggle" ->
                add_to_tab(grid, x1, y1, x2, y2, 2)
            "on" ->
                add_to_tab(grid, x1, y1, x2, y2, 1)
            "off" ->
                add_to_tab(grid, x1, y1, x2, y2, -1)
        end
    end

    def add_to_tab(grid, x1, y1, x2, y2, value) do
        baseLine = Enum.reduce 0..999, %{}, fn y, acc -> Map.put(acc, y, nil) end
        baseGrid = Enum.reduce 0..999, %{}, fn x, acc -> Map.put(acc, x, baseLine) end
        partialLine = Enum.reduce y1..y2, %{}, fn y, acc -> Map.put(acc, y, value) end
        partialGrid = Enum.reduce x1..x2, %{}, fn x, acc -> Map.put(acc, x, partialLine) end
        mergeMap = Map.merge(baseGrid, partialGrid)

        Map.merge grid, mergeMap, fn _, v1, v2 -> 
            Map.merge v1, v2, fn _, vv1, vv2 ->
                merge(vv1, vv2)
            end
        end
    end

    def merge(a, nil), do: a
    def merge(a, b) when a + b < 0, do: a
    def merge(a, b), do: a + b

    def get_instructions(s) do
        {i, firstPos, secondPos} = split_instruction(s)
        {s1, s2} = split_positions(firstPos)
        {f1, f2} = split_positions(secondPos)
        {i, s1, s2, f1, f2} 
    end

    def split_instruction(s) do
        a = String.split(s, " ")
        case Enum.at(a,1) do
            "on" ->
                [_, _, firstPos, _, secondPos] = a
                {"on", firstPos, secondPos}
            "off" ->
                [_, _, firstPos, _, secondPos] = a
                {"off", firstPos, secondPos}
            _ ->
                [_, firstPos, _, secondPos] = a
                {"toggle", firstPos, secondPos}
        end
    end

    def split_positions(s) do
        [start, final] = String.split(s, ",")
        {String.to_integer(start), String.to_integer(final)}
    end

    def start do
        File.read!("lib/6/6-input.txt") 
        |> String.split("\n") 
        |> parse_input(0)     
    end
end