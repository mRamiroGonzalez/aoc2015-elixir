
# AOC 2015 6-2


defmodule Tabs do
    def get(tab, x, y) do
        Enum.at(Enum.at(tab,x),y)
    end

    def set(tab, x, y, val) do
        row = Enum.at(tab, x)
        row = List.replace_at(row, y, val)
        List.replace_at(tab, x, row)
    end

    def pprint(tab) do
        Enum.each tab, fn(line) ->
            IO.puts "#{inspect line}"  
        end
    end

    def replace(tab, range, val)do
        Enum.reduce range[:x1]..range[:x2], tab, fn(x, acc) ->                 
            Enum.reduce range[:y1]..range[:y2], acc, fn y, acc2 ->
                set(acc2, x, y, val) 
            end
        end
    end

    def increase(tab, range, value\\1)do
        Enum.reduce range[:x1]..range[:x2], tab, fn(x, acc) ->                 
            Enum.reduce range[:y1]..range[:y2], acc, fn y, acc2 ->
                set(acc2, x, y, get(tab, x, y) + value) 
            end
        end
    end

    def decrease(tab, range, value\\1)do
        Enum.reduce range[:x1]..range[:x2], tab, fn(x, acc) ->                 
            Enum.reduce range[:y1]..range[:y2], acc, fn y, acc2 ->
                if(get(tab, x, y) > 0) do
                    set(acc2, x, y, get(tab, x, y) - value) 
                else
                    set(acc, x, y, 0)
                end
            end
        end
    end

    def count(tab) do
        Enum.reduce tab, 0, fn(line, acc) ->
            acc + Enum.reduce line, 0, fn(cell, acc2) ->
                acc2 + cell
            end
        end
    end

    def create_tab(side, val\\0) do 
        line = Enum.reduce 0..side-1, [], fn _, acc -> acc ++ [val] end
        Enum.reduce 0..side-1, [], fn _, acc -> acc ++ [line] end
    end
end

defmodule Aoc do
    alias Tabs

    def parse_input(line) do
        tab = Tabs.create_tab(1000)
        IO.puts length tab
        parse_input(line, tab) 
    end
    def parse_input(line, tab, acc\\1)
    def parse_input([h|t], tab, acc) do
        instruction = h |> get_instructions
        IO.puts "#{acc}> Perform:#{instruction[:i]} From:(#{instruction[:x1]},#{instruction[:y1]}) To:(#{instruction[:x2]},#{instruction[:y2]})"  
        tab = case instruction[:i] do
            "on" ->
                Tabs.increase(tab, Map.drop(instruction, [:i]))
            "off" ->
                Tabs.decrease(tab, Map.drop(instruction, [:i]))
            "toggle" ->
                Tabs.increase(tab, Map.drop(instruction, [:i]), 2)
        end
        parse_input(t, tab, acc + 1)
    end
    def parse_input([], tab, _) do
        #Tabs.pprint tab
        IO.puts Tabs.count(tab)
    end

    def get_instructions(s) do
        {i, firstPos, secondPos} = split_instruction(s)
        {s1, s2} = split_positions(firstPos)
        {f1, f2} = split_positions(secondPos)
        %{i: i, x1: s1, y1: s2, x2: f1, y2: f2} 
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
|> Aoc.parse_input()
IO.puts "#{inspect :calendar.universal_time()}"