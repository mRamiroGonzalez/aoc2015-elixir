
# AOC 2015 6-2

# 543903

defmodule Aoc do

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
                a = Enum.reduce 0..999, %{}, fn y, acc -> Map.put(acc, y, nil) end
                b = Enum.reduce 0..999, %{}, fn x, acc -> Map.put(acc, x, a) end
                c = Enum.reduce y1..y2, %{}, fn y, acc -> Map.put(acc, y, 2) end
                d = Enum.reduce x1..x2, %{}, fn x, acc -> Map.put(acc, x, c) end
                onMap = Map.merge(b, d)
                Map.merge(grid, onMap, fn _, v1, v2 -> 
                    Map.merge(v1, v2, fn _, vv1, vv2 ->
                        if(vv2 == nil) do
                            vv1
                        else
                            vv1 + vv2
                        end
                    end) 
                end)
            "on" ->
                a = Enum.reduce 0..999, %{}, fn y, acc -> Map.put(acc, y, nil) end
                b = Enum.reduce 0..999, %{}, fn x, acc -> Map.put(acc, x, a) end
                c = Enum.reduce y1..y2, %{}, fn y, acc -> Map.put(acc, y, 1) end
                d = Enum.reduce x1..x2, %{}, fn x, acc -> Map.put(acc, x, c) end
                onMap = Map.merge(b, d)
                Map.merge(grid, onMap, fn _, v1, v2 -> 
                    Map.merge(v1, v2, fn _, vv1, vv2 ->
                        if(vv2 == nil) do
                            vv1
                        else
                            vv1 + vv2
                        end
                    end) 
                end)
            "off" ->
                a = Enum.reduce 0..999, %{}, fn y, acc -> Map.put(acc, y, nil) end
                b = Enum.reduce 0..999, %{}, fn x, acc -> Map.put(acc, x, a) end
                c = Enum.reduce y1..y2, %{}, fn y, acc -> Map.put(acc, y, -1) end
                d = Enum.reduce x1..x2, %{}, fn x, acc -> Map.put(acc, x, c) end
                offMap = Map.merge(b, d)
                Map.merge(grid, offMap, fn _, v1, v2 -> 
                    Map.merge(v1, v2, fn _, vv1, vv2 ->
                        if(vv2 == nil) do
                            vv1
                        else
                            if (vv1 > 0) do
                                vv1 + vv2
                            else
                               vv1 
                            end
                        end
                    end) 
                end)
        end
    end

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
end

IO.puts "#{inspect :calendar.universal_time()}"
File.read!("6-input.txt") 
|> String.split("\n") 
|> Aoc.parse_input(0)
IO.puts "#{inspect :calendar.universal_time()}"